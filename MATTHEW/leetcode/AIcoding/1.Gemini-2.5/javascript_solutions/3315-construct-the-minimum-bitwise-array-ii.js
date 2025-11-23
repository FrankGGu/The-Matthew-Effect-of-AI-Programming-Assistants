var constructMinimumBitwiseArray = function(nums) {
    let orAllNums = 0;
    for (let i = 0; i < nums.length; i++) {
        orAllNums |= nums[i];
    }

    let andAllNums = -1; 
    if (nums.length > 0) {
        andAllNums = nums[0];
        for (let i = 1; i < nums.length; i++) {
            andAllNums &= nums[i];
        }
    } else {
        return 0;
    }

    return orAllNums ^ andAllNums;
};