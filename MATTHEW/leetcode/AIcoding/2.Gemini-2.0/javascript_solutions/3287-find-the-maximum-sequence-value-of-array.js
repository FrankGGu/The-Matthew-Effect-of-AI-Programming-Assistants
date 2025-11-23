var maxScore = function(nums) {
    let n = nums.length;
    let maxVal = -Infinity;
    for (let i = 0; i < n; i++) {
        for (let j = 0; j < n; j++) {
            for (let k = 0; k < n; k++) {
                let currentVal = nums[i] * nums[j] - nums[k];
                maxVal = Math.max(maxVal, currentVal);
            }
        }
    }
    return maxVal;
};