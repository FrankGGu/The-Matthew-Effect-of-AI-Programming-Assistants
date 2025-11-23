var maximizeXor = function(nums, maximumBit) {
    const maxNum = (1 << maximumBit) - 1;
    const result = [];
    for (let num of nums) {
        result.push(num ^ maxNum);
    }
    return result;
};