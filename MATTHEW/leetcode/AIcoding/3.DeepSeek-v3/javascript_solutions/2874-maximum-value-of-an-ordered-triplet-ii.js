var maximumTripletValue = function(nums) {
    let max1 = -Infinity;
    let max2 = -Infinity;
    let res = 0;
    for (let i = 0; i < nums.length; i++) {
        res = Math.max(res, max2 * nums[i]);
        max2 = Math.max(max2, max1 - nums[i]);
        max1 = Math.max(max1, nums[i]);
    }
    return res;
};