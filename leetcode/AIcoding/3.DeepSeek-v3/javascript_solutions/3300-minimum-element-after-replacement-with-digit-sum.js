var minElementAfterDecrement = function(nums) {
    let n = nums.length;
    if (n === 1) return nums[0];
    nums.sort((a, b) => a - b);
    nums[0] = 1;
    for (let i = 1; i < n; i++) {
        if (nums[i] > nums[i - 1]) {
            nums[i] = nums[i - 1] + 1;
        }
    }
    return nums[n - 1];
};