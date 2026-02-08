var numSubarrayBoundedMax = function(nums, left, right) {
    let count = 0;
    let start = -1;
    let end = -1;

    for (let i = 0; i < nums.length; i++) {
        if (nums[i] > right) {
            start = i;
            end = i;
        } else if (nums[i] >= left) {
            end = i;
        }
        count += end - start;
    }

    return count;
};