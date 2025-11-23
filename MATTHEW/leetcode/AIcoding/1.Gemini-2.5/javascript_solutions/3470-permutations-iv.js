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