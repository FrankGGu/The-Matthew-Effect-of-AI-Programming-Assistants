var minPairSum = function(nums) {
    nums.sort((a, b) => a - b);
    let maxPairSum = 0;
    let left = 0;
    let right = nums.length - 1;

    while (left < right) {
        maxPairSum = Math.max(maxPairSum, nums[left] + nums[right]);
        left++;
        right--;
    }

    return maxPairSum;
};