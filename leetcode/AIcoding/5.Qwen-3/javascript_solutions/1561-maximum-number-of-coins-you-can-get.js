var maxCoins = function(coins) {
    coins.sort((a, b) => b - a);
    let result = 0;
    for (let i = 1; i < coins.length; i += 2) {
        result += coins[i];
    }
    return result;
};