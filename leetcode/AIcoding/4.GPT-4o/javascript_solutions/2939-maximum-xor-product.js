var maximumXOR = function(nums) {
    let maxXor = 0;
    for (let num of nums) {
        maxXor |= num;
    }
    return maxXor;
};