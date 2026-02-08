var maxArrayValue = function(nums) {
    let n = nums.length;
    let sum = nums[n - 1];
    for (let i = n - 2; i >= 0; i--) {
        if (nums[i] <= sum) {
            sum += nums[i];
        } else {
            sum = nums[i];
        }
    }
    return sum;
};