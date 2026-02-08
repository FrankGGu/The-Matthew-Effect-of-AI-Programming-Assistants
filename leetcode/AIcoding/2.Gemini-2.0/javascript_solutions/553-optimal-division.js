var optimalDivision = function(nums) {
    if (nums.length === 1) {
        return nums[0].toString();
    }
    if (nums.length === 2) {
        return nums[0] + "/" + nums[1];
    }
    let result = nums[0] + "/(" + nums[1];
    for (let i = 2; i < nums.length; i++) {
        result += "/" + nums[i];
    }
    result += ")";
    return result;
};