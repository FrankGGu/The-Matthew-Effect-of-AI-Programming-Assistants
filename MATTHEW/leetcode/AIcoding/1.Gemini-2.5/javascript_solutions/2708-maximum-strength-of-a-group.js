var maxStrength = function(nums) {
    let n = nums.length;
    let maxStrengthValue = -Infinity;

    for (let i = 1; i < (1 << n); i++) {
        let currentProduct = 1;
        for (let j = 0; j < n; j++) {
            if ((i >> j) & 1) {
                currentProduct *= nums[j];
            }
        }
        maxStrengthValue = Math.max(maxStrengthValue, currentProduct);
    }

    return maxStrengthValue;
};