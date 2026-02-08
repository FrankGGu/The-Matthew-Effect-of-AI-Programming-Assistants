var maximumSum = function(nums) {
    let n = nums.length;
    let maxSum = -Infinity;

    for (let i = 0; i < n; i++) {
        for (let j = i + 1; j < n; j++) {
            for (let k = j + 1; k < n; k++) {
                let currentSum = nums[i] + nums[j] + nums[k];
                maxSum = Math.max(maxSum, currentSum);
            }
        }
    }

    return maxSum;
};