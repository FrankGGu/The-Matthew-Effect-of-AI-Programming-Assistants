function maximumSum(nums, k) {
    let maxSum = 0;
    let currentSum = 0;
    let map = new Map();

    for (let i = 0; i < nums.length; i++) {
        if (i >= k) {
            if (map.get(nums[i - k]) === 1) {
                map.delete(nums[i - k]);
                currentSum -= nums[i - k];
            } else {
                map.set(nums[i - k], map.get(nums[i - k]) - 1);
            }
        }

        map.set(nums[i], (map.get(nums[i]) || 0) + 1);
        currentSum += nums[i];

        if (i >= k - 1 && map.size === k) {
            maxSum = Math.max(maxSum, currentSum);
        }
    }

    return maxSum;
}