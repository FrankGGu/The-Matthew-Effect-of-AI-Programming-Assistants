var getAverages = function(nums, k) {
    const n = nums.length;
    const averages = new Array(n).fill(-1);
    const windowSize = 2 * k + 1;

    if (windowSize > n) {
        return averages;
    }

    let currentSum = 0;
    for (let i = 0; i < windowSize; i++) {
        currentSum += nums[i];
    }

    averages[k] = Math.floor(currentSum / windowSize);

    for (let i = k + 1; i < n - k; i++) {
        currentSum = currentSum - nums[i - k - 1] + nums[i + k];
        averages[i] = Math.floor(currentSum / windowSize);
    }

    return averages;
};