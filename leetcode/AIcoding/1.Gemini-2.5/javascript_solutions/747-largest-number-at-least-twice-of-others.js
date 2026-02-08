var dominantIndex = function(nums) {
    if (nums.length === 1) {
        return 0;
    }

    let max1 = -1;
    let max1Index = -1;
    let max2 = -1;

    for (let i = 0; i < nums.length; i++) {
        if (nums[i] > max1) {
            max2 = max1;
            max1 = nums[i];
            max1Index = i;
        } else if (nums[i] > max2) {
            max2 = nums[i];
        }
    }

    if (max1 >= 2 * max2) {
        return max1Index;
    } else {
        return -1;
    }
};