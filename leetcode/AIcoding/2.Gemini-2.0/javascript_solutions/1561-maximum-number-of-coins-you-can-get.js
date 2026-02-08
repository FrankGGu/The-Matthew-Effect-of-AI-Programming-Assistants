var maxCoins = function(piles) {
    piles.sort((a, b) => a - b);
    let coins = 0;
    let l = 0;
    let r = piles.length - 2;

    while (l < r) {
        coins += piles[r];
        l++;
        r -= 2;
    }

    return coins;
};