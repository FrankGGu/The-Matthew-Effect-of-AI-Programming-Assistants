var getMaximumConsecutive = function(coins) {
    coins.sort((a, b) => a - b);
    let maxConsecutive = 0;

    for (let coin of coins) {
        if (coin > maxConsecutive + 1) break;
        maxConsecutive += coin;
    }

    return maxConsecutive + 1;
};