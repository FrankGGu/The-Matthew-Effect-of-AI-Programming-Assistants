var minPairSum = function(nums) {
    nums.sort((a, b) => a - b);
    let maxSum = 0;
    let left = 0, right = nums.length - 1;
    while (left < right) {
        maxSum = Math.max(maxSum, nums[left] + nums[right]);
        left++;
        right--;
    }
    return maxSum;
};