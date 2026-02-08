var subsets = function(nums) {
    const result = [];
    const backtrack = (start, path) => {
        result.push(path);
        for (let i = start; i < nums.length; i++) {
            backtrack(i + 1, path.concat(nums[i]));
        }
    };
    backtrack(0, []);
    return result;
};