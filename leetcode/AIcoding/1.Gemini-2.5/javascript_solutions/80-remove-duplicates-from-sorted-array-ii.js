var removeDuplicates = function(nums) {
    if (nums.length === 0) {
        return 0;
    }

    let k = 0;

    for (let j = 0; j < nums.length; j++) {
        if (k < 2 || nums[j] !== nums[k - 2]) {
            nums[k] = nums[j];
            k++;
        }
    }

    return k;
};