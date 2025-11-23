var canMakeMagicPermutation = function(nums) {
    nums.sort((a, b) => a - b);

    for (let i = 0; i < nums.length; i++) {
        if (nums[i] > i + 1) {
            return false;
        }
    }

    return true;
};