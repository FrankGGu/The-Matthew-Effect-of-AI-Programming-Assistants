var maximumSum = function(nums) {
    const n = nums.length;
    let maxSum = 0;

    for (let k = 1; k <= n; k++) {
        let currentSum = 0;
        for (let x = 1; ; x++) {
            const j = k * x * x;
            if (j > n) {
                break;
            }
            currentSum += nums[j - 1];
        }
        if (currentSum > maxSum) {
            maxSum = currentSum;
        }
    }

    return maxSum;
};