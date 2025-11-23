var optimalDivision = function(nums) {
    if (nums.length === 1) return [nums[0].toString()];
    if (nums.length === 2) return [nums[0].toString() + "/" + nums[1].toString()];
    let result = nums[0].toString() + "/(";
    for (let i = 1; i < nums.length - 1; i++) {
        result += nums[i] + "/";
    }
    result += nums[nums.length - 1] + ")";
    return [result];
};