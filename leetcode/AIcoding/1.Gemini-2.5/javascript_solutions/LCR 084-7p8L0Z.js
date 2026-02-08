var permuteUnique = function(nums) {
    const result = [];
    nums.sort((a, b) => a - b);

    function backtrack(currentPermutation, used) {
        if (currentPermutation.length === nums.length) {
            result.push([...currentPermutation]);
            return;
        }

        for (let i = 0; i < nums.length; i++) {
            if (used[i]) {
                continue;
            }

            if (i > 0 && nums[i] === nums[i - 1] && !used[i - 1]) {
                continue;
            }

            currentPermutation.push(nums[i]);
            used[i] = true;
            backtrack(currentPermutation, used);
            used[i] = false;
            currentPermutation.pop();
        }
    }

    const used = new Array(nums.length).fill(false);
    backtrack([], used);
    return result;
};