var minCount = function(coins) {
    let count = 0;
    for (let coin of coins) {
        count += Math.ceil(coin / 2);
    }
    return count;
};