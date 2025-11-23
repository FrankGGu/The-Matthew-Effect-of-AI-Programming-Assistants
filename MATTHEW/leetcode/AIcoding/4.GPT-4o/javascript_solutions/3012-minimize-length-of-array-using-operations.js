var minimizeArrayLength = function(nums) {
    let uniqueNums = new Set(nums);
    return uniqueNums.size;
};