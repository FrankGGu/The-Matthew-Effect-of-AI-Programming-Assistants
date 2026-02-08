var permuteUnique = function(nums) {
    const result = [];
    nums.sort((a, b) => a - b);
    const used = new Array(nums.length).fill(false);

    const backtrack = (current) => {
        if (current.length === nums.length) {
            result.push([...current]);
            return;
        }

        for (let i = 0; i < nums.length; i++) {
            if (used[i] || (i > 0 && nums[i] === nums[i - 1] && !used[i - 1])) {
                continue;
            }
            used[i] = true;
            current.push(nums[i]);
            backtrack(current);
            current.pop();
            used[i] = false;
        }
    };

    backtrack([]);
    return result;
};