var permute = function(nums) {
    const result = [];
    const currentPermutation = [];
    const used = new Array(nums.length).fill(false);

    function backtrack() {
        if (currentPermutation.length === nums.length) {
            result.push([...currentPermutation]);
            return;
        }

        for (let i = 0; i < nums.length; i++) {
            if (!used[i]) {
                used[i] = true;
                currentPermutation.push(nums[i]);
                backtrack();
                currentPermutation.pop();
                used[i] = false;
            }
        }
    }

    backtrack();
    return result;
};