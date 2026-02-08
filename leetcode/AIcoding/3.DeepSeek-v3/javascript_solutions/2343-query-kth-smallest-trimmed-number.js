var smallestTrimmedNumbers = function(nums, queries) {
    const result = [];
    for (const [k, trim] of queries) {
        const trimmed = nums.map(num => {
            const len = num.length;
            return num.slice(len - trim);
        });
        const indices = trimmed.map((_, i) => i);
        indices.sort((a, b) => {
            if (trimmed[a] !== trimmed[b]) {
                return trimmed[a].localeCompare(trimmed[b]);
            } else {
                return a - b;
            }
        });
        result.push(indices[k - 1]);
    }
    return result;
};