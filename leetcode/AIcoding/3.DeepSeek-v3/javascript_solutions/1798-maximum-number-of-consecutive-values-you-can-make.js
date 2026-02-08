var getMaximumConsecutive = function(coins) {
    coins.sort((a, b) => a - b);
    let max = 1;
    for (const coin of coins) {
        if (coin > max) break;
        max += coin;
    }
    return max;
};