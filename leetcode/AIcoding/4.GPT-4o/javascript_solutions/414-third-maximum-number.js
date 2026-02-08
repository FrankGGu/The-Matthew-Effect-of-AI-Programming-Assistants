var thirdMax = function(nums) {
    let uniqueNums = [...new Set(nums)];
    uniqueNums.sort((a, b) => b - a);
    return uniqueNums.length >= 3 ? uniqueNums[2] : uniqueNums[0];
};