var minimumOneBitOperations = function(n) {
    if (n === 0) return 0;
    let highestBit = 0;
    while (1 << highestBit <= n) {
        highestBit++;
    }
    return (1 << highestBit) - 1 - minimumOneBitOperations(n ^ (1 << (highestBit - 1)));
};