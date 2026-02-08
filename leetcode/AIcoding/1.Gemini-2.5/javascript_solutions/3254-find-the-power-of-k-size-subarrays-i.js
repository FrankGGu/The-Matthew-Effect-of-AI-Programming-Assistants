var findThePowerOfKSizeSubarrays = function(nums, k) {
    const n = nums.length;
    const result = [];

    if (k <= 0 || k > n) {
        return result;
    }

    let currentWindowSum = 0;
    for (let i = 0; i < k; i++) {
        currentWindowSum += nums[i];
    }
    result.push(currentWindowSum);

    for (let i = k; i < n; i++) {
        currentWindowSum -= nums[i - k];
        currentWindowSum += nums[i];
        result.push(currentWindowSum);
    }

    return result;
};