var permuteUnique = function(nums) {
    const result = [];
    nums.sort((a, b) => a - b);

    function backtrack(arr, used) {
        if (arr.length === nums.length) {
            result.push([...arr]);
            return;
        }

        for (let i = 0; i < nums.length; i++) {
            if (used[i] || (i > 0 && nums[i] === nums[i - 1] && !used[i - 1])) {
                continue;
            }

            arr.push(nums[i]);
            used[i] = true;
            backtrack(arr, used);
            used[i] = false;
            arr.pop();
        }
    }

    backtrack([], Array(nums.length).fill(false));
    return result;
};