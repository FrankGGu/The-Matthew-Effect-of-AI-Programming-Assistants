function maxCoinBonus(coins) {
    let maxCoins = 0;
    let n = coins.length;

    for (let i = 0; i < n; i++) {
        maxCoins = Math.max(maxCoins, coins[i]);
        if (i > 0) {
            coins[i] += coins[i - 1];
        }
    }

    return maxCoins;
}