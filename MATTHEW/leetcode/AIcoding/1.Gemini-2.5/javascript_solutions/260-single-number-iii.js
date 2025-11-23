var singleNumber = function(nums) {
    let xorSum = 0;
    for (const num of nums) {
        xorSum ^= num;
    }

    // Find the rightmost set bit in xorSum.
    // This bit must be different between the two unique numbers.
    let diffBit = xorSum & (-xorSum);

    let num1 = 0;
    let num2 = 0;

    // Partition the numbers into two groups based on the diffBit.
    // XOR numbers in each group to find the two unique numbers.
    for (const num of nums) {
        if ((num & diffBit) !== 0) {
            num1 ^= num;
        } else {
            num2 ^= num;
        }
    }

    return [num1, num2];
};