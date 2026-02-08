function maxSum(nums, k) {
    nums.sort((a, b) => b - a);
    let sum = 0;
    for (let i = 0; i < k; i++) {
        sum += nums[i];
    }
    return sum;
}