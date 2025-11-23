function minPositiveSumSubarray(nums) {
    let minSum = Infinity;
    let currentSum = 0;

    for (let i = 0; i < nums.length; i++) {
        currentSum += nums[i];
        if (currentSum > 0) {
            minSum = Math.min(minSum, currentSum);
        } else {
            currentSum = 0;
        }
    }

    return minSum === Infinity ? -1 : minSum;
}