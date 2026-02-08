var findWinningPlayer = function(skills, k) {
    let n = skills.length;
    let maxIndex = 0;
    for (let i = 1; i < n; i++) {
        if (skills[i] > skills[maxIndex]) {
            maxIndex = i;
        }
    }

    let currentWinner = 0;
    let winStreak = 0;

    for (let i = 1; i < n; i++) {
        if (skills[currentWinner] > skills[i]) {
            winStreak++;
        } else {
            currentWinner = i;
            winStreak = 1;
        }

        if (winStreak === k || currentWinner === maxIndex) {
            return currentWinner;
        }
    }

    return maxIndex;
};