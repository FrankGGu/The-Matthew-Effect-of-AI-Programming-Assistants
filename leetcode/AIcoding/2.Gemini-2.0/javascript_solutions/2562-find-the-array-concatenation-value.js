var findTheArrayConcVal = function(nums) {
    let sum = 0;
    let left = 0;
    let right = nums.length - 1;

    while (left <= right) {
        if (left === right) {
            sum += nums[left];
        } else {
            sum += parseInt(String(nums[left]) + String(nums[right]));
        }
        left++;
        right--;
    }

    return sum;
};