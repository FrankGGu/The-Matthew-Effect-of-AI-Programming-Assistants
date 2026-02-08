var maximumSum = function(nums) {
    const n = nums.length;
    let maxSum = -Infinity;

    for (let k = 1; k <= n; k++) {
        let currentSum = 0;
        for (let i = 1; i * i * k <= n; i++) {
            const index = i * i * k;
            currentSum += nums[index - 1];
        }
        if (currentSum > maxSum) {
            maxSum = currentSum;
        }
    }

    return maxSum;
};