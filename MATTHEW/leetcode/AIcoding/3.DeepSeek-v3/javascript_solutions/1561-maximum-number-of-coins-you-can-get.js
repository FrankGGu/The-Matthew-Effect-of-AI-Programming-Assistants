var maxCoins = function(piles) {
    piles.sort((a, b) => a - b);
    let res = 0;
    let n = piles.length / 3;
    for (let i = piles.length - 2; i >= n; i -= 2) {
        res += piles[i];
    }
    return res;
};