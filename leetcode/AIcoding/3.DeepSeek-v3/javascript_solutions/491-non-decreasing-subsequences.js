var findSubsequences = function(nums) {
    const result = [];
    const path = [];

    const backtrack = (startIndex) => {
        if (path.length >= 2) {
            result.push([...path]);
        }
        const used = new Set();
        for (let i = startIndex; i < nums.length; i++) {
            if (used.has(nums[i])) continue;
            if (path.length === 0 || nums[i] >= path[path.length - 1]) {
                used.add(nums[i]);
                path.push(nums[i]);
                backtrack(i + 1);
                path.pop();
            }
        }
    };

    backtrack(0);
    return result;
};