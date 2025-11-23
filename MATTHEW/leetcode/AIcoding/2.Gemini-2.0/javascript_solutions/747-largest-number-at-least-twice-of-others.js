var dominantIndex = function(nums) {
    if (nums.length === 1) return 0;

    let max = -1;
    let maxIndex = -1;
    let secondMax = -1;

    for (let i = 0; i < nums.length; i++) {
        if (nums[i] > max) {
            secondMax = max;
            max = nums[i];
            maxIndex = i;
        } else if (nums[i] > secondMax) {
            secondMax = nums[i];
        }
    }

    if (max >= 2 * secondMax) {
        return maxIndex;
    } else {
        return -1;
    }
};