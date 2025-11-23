var maximumXOR = function(nums) {
    let xorSum = 0;
    for (let num of nums) {
        xorSum |= num;
    }
    return xorSum;
};