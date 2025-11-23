var findTheArrayConcVal = function(nums) {
    let concValue = 0;
    let left = 0;
    let right = nums.length - 1;

    while (left <= right) {
        if (left === right) {
            concValue += nums[left];
        } else {
            const concatenated = parseInt(nums[left].toString() + nums[right].toString());
            concValue += concatenated;
        }
        left++;
        right--;
    }

    return concValue;
};