var permuteUnique = function(nums) {
    const result = [];
    const currentPermutation = [];
    const used = new Array(nums.length).fill(false);

    nums.sort((a, b) => a - b);

    function backtrack() {
        if (currentPermutation.length === nums.length) {
            result.push([...currentPermutation]);
            return;
        }

        for (let i = 0; i < nums.length; i++) {
            if (used[i]) {
                continue;
            }

            // Skip duplicates: If the current number is the same as the previous number,
            // and the previous number was NOT used (meaning we are exploring a branch
            // where the previous duplicate was skipped), then we should also skip the
            // current number to avoid duplicate permutations.
            if (i > 0 && nums[i] === nums[i - 1] && !used[i - 1]) {
                continue;
            }

            currentPermutation.push(nums[i]);
            used[i] = true;
            backtrack();
            used[i] = false;
            currentPermutation.pop();
        }
    }

    backtrack();
    return result;
};