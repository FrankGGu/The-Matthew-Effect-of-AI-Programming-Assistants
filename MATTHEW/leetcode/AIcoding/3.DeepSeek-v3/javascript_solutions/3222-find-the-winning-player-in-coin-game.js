var findWinningPlayer = function(piles, k) {
    let max = piles[0];
    let maxIndex = 0;
    let currentStreak = 0;

    for (let i = 1; i < piles.length; i++) {
        if (piles[i] > max) {
            max = piles[i];
            maxIndex = i;
            currentStreak = 1;
        } else {
            currentStreak++;
        }

        if (currentStreak === k) {
            return maxIndex;
        }
    }

    return maxIndex;
};