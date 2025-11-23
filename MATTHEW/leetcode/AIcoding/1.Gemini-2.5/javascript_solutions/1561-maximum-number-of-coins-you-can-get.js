var maxCoins = function(piles) {
    piles.sort((a, b) => a - b);

    let myCoins = 0;
    let left = 0;
    let right = piles.length - 1;

    while (left < right) {
        myCoins += piles[right - 1];
        right -= 2;
        left += 1;
    }

    return myCoins;
};