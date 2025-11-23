function getAverages(nums, k) {
    const n = nums.length;
    const result = new Array(n).fill(-1);
    const windowSize = 2 * k + 1;
    let sum = 0;

    for (let i = 0; i < n; i++) {
        sum += nums[i];
        if (i >= windowSize) {
            sum -= nums[i - windowSize];
        }
        if (i >= windowSize - 1) {
            result[i - k] = Math.floor(sum / windowSize);
        }
    }

    return result;
}