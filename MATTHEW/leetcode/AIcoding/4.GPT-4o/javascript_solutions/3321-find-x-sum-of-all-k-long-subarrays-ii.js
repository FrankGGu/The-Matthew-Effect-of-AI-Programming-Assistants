var xSum = function(nums, k, x) {
    let n = nums.length;
    let sum = 0;
    let currentWindowSum = 0;

    for (let i = 0; i < n; i++) {
        currentWindowSum += nums[i];
        if (i >= k) {
            currentWindowSum -= nums[i - k];
        }
        if (i >= k - 1) {
            if (currentWindowSum === x) {
                sum += 1;
            }
        }
    }

    return sum;
};