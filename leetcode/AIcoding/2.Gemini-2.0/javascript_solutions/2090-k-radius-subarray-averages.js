var getAverages = function(nums, k) {
    const n = nums.length;
    const averages = new Array(n).fill(-1);
    if (2 * k + 1 > n) return averages;

    let windowSum = 0;
    for (let i = 0; i < 2 * k + 1; i++) {
        windowSum += nums[i];
    }

    averages[k] = Math.floor(windowSum / (2 * k + 1));

    for (let i = k + 1; i < n - k; i++) {
        windowSum = windowSum - nums[i - k - 1] + nums[i + k];
        averages[i] = Math.floor(windowSum / (2 * k + 1));
    }

    return averages;
};