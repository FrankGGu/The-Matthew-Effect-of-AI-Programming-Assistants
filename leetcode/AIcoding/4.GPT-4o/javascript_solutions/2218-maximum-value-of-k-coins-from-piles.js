var maxCoins = function(piles) {
    const k = piles.length / 3;
    piles.sort((a, b) => a - b);
    let total = 0;
    for (let i = piles.length - 2; i >= piles.length - k * 2; i -= 2) {
        total += piles[i];
    }
    return total;
};