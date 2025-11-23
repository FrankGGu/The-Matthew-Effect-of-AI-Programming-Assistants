var getAverages = function(nums, k) {
    const n = nums.length;
    const windowSize = 2 * k + 1;
    const result = new Array(n).fill(-1);

    if (windowSize > n) {
        return result;
    }

    let prefixSum = new Array(n + 1).fill(0);
    for (let i = 0; i < n; i++) {
        prefixSum[i + 1] = prefixSum[i] + nums[i];
    }

    for (let i = k; i < n - k; i++) {
        const sum = prefixSum[i + k + 1] - prefixSum[i - k];
        result[i] = Math.floor(sum / windowSize);
    }

    return result;
};