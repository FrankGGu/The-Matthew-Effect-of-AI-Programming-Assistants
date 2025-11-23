var maximumTripletValue = function(nums) {
    let maxVal = 0;
    let maxA = nums[0];

    for (let j = 1; j < nums.length - 1; j++) {
        maxA = Math.max(maxA, nums[j - 1]);
        maxVal = Math.max(maxVal, maxA - nums[j] + nums[j + 1]);
    }

    return maxVal;
};