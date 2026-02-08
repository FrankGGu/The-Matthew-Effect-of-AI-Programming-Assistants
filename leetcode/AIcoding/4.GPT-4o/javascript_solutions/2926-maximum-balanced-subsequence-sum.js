function maximumBalancedSum(nums) {
    const n = nums.length;
    let totalSum = 0;
    let maxSum = 0;

    for (let num of nums) {
        totalSum += num;
    }

    let leftSum = 0;
    let rightSum = 0;

    for (let i = 0; i < n; i++) {
        leftSum += nums[i];
        rightSum = totalSum - leftSum;

        if (leftSum === rightSum) {
            maxSum = Math.max(maxSum, leftSum);
        }
    }

    return maxSum;
}