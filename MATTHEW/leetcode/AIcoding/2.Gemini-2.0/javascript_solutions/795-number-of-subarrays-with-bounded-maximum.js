var numSubarrayBoundedMax = function(nums, left, right) {
    let count = 0;
    let start = -1;
    let end = -1;

    for (let i = 0; i < nums.length; i++) {
        if (nums[i] >= left && nums[i] <= right) {
            end = i;
            count += (end - start);
        } else if (nums[i] < left) {
            if (end !== -1) {
                count += (end - start);
            }
        } else {
            start = i;
            end = -1;
        }
    }

    return count;
};