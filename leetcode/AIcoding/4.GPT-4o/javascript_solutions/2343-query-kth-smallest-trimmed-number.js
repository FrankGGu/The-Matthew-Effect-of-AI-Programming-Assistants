var smallestTrimmedNumbers = function(nums, queries) {
    const results = [];

    for (const [k, trim] of queries) {
        const trimmed = nums.map(num => num.slice(-trim));
        const indexed = trimmed.map((num, idx) => [num, idx]).sort((a, b) => {
            if (a[0] === b[0]) return a[1] - b[1];
            return a[0] - b[0];
        });
        results.push(indexed[k - 1][1]);
    }

    return results;
};