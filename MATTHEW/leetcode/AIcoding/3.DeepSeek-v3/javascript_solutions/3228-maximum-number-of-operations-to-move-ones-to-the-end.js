var maximumNumberOnes = function(nums) {
    let left = 0;
    let right = nums.length - 1;
    let operations = 0;

    while (left < right) {
        if (nums[left] === 1 && nums[right] === 0) {
            operations++;
            left++;
            right--;
        } else {
            if (nums[left] !== 1) {
                left++;
            }
            if (nums[right] !== 0) {
                right--;
            }
        }
    }

    return operations;
};