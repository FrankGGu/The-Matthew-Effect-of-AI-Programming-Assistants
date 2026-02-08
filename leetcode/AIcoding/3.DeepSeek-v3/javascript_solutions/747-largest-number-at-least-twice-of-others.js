var dominantIndex = function(nums) {
    let max = -Infinity;
    let secondMax = -Infinity;
    let maxIndex = -1;

    for (let i = 0; i < nums.length; i++) {
        if (nums[i] > max) {
            secondMax = max;
            max = nums[i];
            maxIndex = i;
        } else if (nums[i] > secondMax) {
            secondMax = nums[i];
        }
    }

    return max >= secondMax * 2 ? maxIndex : -1;
};