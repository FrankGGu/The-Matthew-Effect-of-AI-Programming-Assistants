function maximizeSum(nums, k) {
    nums.sort((a, b) => b - a);
    let totalSum = 0;
    for (let i = 0; i < k; i++) {
        totalSum += nums[i] + i;
    }
    return totalSum;
}