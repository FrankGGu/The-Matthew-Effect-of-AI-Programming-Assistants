var getMaximumConsecutive = function(coins) {
    coins.sort((a, b) => a - b);
    let maxReachable = 0;
    for (let coin of coins) {
        if (coin <= maxReachable + 1) {
            maxReachable += coin;
        } else {
            break;
        }
    }
    return maxReachable + 1;
};