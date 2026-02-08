var permuteUnique = function(nums) {
    const results = [];
    nums.sort((a, b) => a - b);

    const backtrack = (path, used) => {
        if (path.length === nums.length) {
            results.push([...path]);
            return;
        }
        for (let i = 0; i < nums.length; i++) {
            if (used[i]) continue;
            if (i > 0 && nums[i] === nums[i - 1] && !used[i - 1]) continue;
            used[i] = true;
            path.push(nums[i]);
            backtrack(path, used);
            path.pop();
            used[i] = false;
        }
    };

    backtrack([], Array(nums.length).fill(false));
    return results;
};