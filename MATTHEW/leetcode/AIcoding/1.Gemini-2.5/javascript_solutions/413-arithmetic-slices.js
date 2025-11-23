var numberOfArithmeticSlices = function(nums) {
    const n = nums.length;
    if (n < 3) {
        return 0;
    }

    let totalSlices = 0;
    let currentConsecutiveSlices = 0;

    for (let i = 2; i < n; i++) {
        if (nums[i] - nums[i - 1] === nums[i - 1] - nums[i - 2]) {
            currentConsecutiveSlices++;
            totalSlices += currentConsecutiveSlices;
        } else {
            currentConsecutiveSlices = 0;
        }
    }

    return totalSlices;
};