var maxMultiplicationScore = function(nums, k) {
    const n = nums.length;
    let maxScore = 0;
    for (let i = 0; i < n; i++) {
        for (let j = i + 1; j < n; j++) {
            for (let l = j + 1; l < n; l++) {
                const product = nums[i] * nums[j] * nums[l];
                if (product > maxScore) {
                    maxScore = product;
                }
            }
        }
    }
    return maxScore % k;
};