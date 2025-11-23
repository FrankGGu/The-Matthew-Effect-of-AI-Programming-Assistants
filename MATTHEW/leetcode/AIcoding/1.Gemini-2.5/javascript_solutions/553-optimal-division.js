var optimalDivision = function(nums) {
    const n = nums.length;

    if (n === 1) {
        return nums[0].toString();
    }

    if (n === 2) {
        return nums[0].toString() + "/" + nums[1].toString();
    }

    let result = nums[0].toString() + "/(";
    for (let i = 1; i < n; i++) {
        result += nums[i].toString();
        if (i < n - 1) {
            result += "/";
        }
    }
    result += ")";

    return result;
};