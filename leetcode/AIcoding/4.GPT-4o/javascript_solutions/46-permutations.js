var permute = function(nums) {
    const results = [];

    const backtrack = (path, remaining) => {
        if (remaining.length === 0) {
            results.push(path);
            return;
        }
        for (let i = 0; i < remaining.length; i++) {
            backtrack([...path, remaining[i]], [...remaining.slice(0, i), ...remaining.slice(i + 1)]);
        }
    };

    backtrack([], nums);
    return results;
};