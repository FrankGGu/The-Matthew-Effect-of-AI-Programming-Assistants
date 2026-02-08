var minimumOperations = function(nums) {
    const uniqueNums = new Set(nums);
    return uniqueNums.has(0) ? uniqueNums.size - 1 : uniqueNums.size;
};