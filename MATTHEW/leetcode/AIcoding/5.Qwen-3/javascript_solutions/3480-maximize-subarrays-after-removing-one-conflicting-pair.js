function maxSubarraysOnRemoval(nums) {
    let n = nums.length;
    let maxSubarrays = 0;
    let currentSum = 0;
    let minPrefixSum = 0;
    let prefixSum = 0;

    for (let i = 0; i < n; i++) {
        prefixSum += nums[i];
        if (currentSum > 0) {
            currentSum = Math.max(currentSum + nums[i], nums[i]);
        } else {
            currentSum = nums[i];
        }

        if (prefixSum - minPrefixSum > 0) {
            maxSubarrays++;
            currentSum = 0;
            minPrefixSum = prefixSum;
        }
    }

    return maxSubarrays === 0 ? 1 : maxSubarrays;
}