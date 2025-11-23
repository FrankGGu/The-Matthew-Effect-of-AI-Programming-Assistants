function dominantIndex(nums) {
    let max = -Infinity;
    let secondMax = -Infinity;
    let index = -1;

    for (let i = 0; i < nums.length; i++) {
        if (nums[i] > max) {
            secondMax = max;
            max = nums[i];
            index = i;
        } else if (nums[i] > secondMax) {
            secondMax = nums[i];
        }
    }

    return max >= secondMax * 2 ? index : -1;
}