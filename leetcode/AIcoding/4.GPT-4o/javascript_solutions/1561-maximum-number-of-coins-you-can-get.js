var maxCoins = function(piles) {
    piles.sort((a, b) => a - b);
    let maxCoins = 0;
    const n = piles.length;
    for (let i = n / 3; i < n; i += 2) {
        maxCoins += piles[i];
    }
    return maxCoins;
};