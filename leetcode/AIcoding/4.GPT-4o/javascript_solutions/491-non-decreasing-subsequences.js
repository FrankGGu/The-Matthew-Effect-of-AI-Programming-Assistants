var findSubsequences = function(nums) {
    const result = new Set();

    const backtrack = (start, path) => {
        if (path.length > 1) {
            result.add(path.join(','));
        }
        for (let i = start; i < nums.length; i++) {
            if (path.length === 0 || nums[i] >= path[path.length - 1]) {
                path.push(nums[i]);
                backtrack(i + 1, path);
                path.pop();
            }
        }
    };

    backtrack(0, []);
    return Array.from(result).map(seq => seq.split(',').map(Number));
};