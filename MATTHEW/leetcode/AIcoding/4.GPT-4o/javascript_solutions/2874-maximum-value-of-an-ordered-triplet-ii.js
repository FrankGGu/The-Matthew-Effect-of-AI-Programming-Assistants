function maximumTripletValue(nums) {
    let maxValue = 0;
    let max1 = 0, max2 = 0;

    for (let i = 0; i < nums.length; i++) {
        max1 = Math.max(max1, nums[i]);
        if (i > 0) {
            max2 = Math.max(max2, max1 - nums[i]);
        }
        if (i > 1) {
            maxValue = Math.max(maxValue, max2 + nums[i]);
        }
    }

    return maxValue;
}