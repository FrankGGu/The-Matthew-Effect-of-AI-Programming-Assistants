function numOfSubarrays(nums, k, threshold) {
    let sum = 0;
    for (let i = 0; i < k; i++) {
        sum += nums[i];
    }
    let count = 0;
    if (sum / k >= threshold) count++;
    for (let i = k; i < nums.length; i++) {
        sum += nums[i] - nums[i - k];
        if (sum / k >= threshold) count++;
    }
    return count;
}