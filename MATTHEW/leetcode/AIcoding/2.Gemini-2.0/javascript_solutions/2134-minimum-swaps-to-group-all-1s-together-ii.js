var minSwaps = function(nums) {
    let n = nums.length;
    let ones = 0;
    for (let num of nums) {
        if (num === 1) {
            ones++;
        }
    }

    let windowOnes = 0;
    for (let i = 0; i < ones; i++) {
        if (nums[i] === 1) {
            windowOnes++;
        }
    }

    let maxOnes = windowOnes;
    for (let i = ones; i < n; i++) {
        if (nums[i] === 1) {
            windowOnes++;
        }
        if (nums[i - ones] === 1) {
            windowOnes--;
        }
        maxOnes = Math.max(maxOnes, windowOnes);
    }

    return ones - maxOnes;
};