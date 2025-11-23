function findFirstKGamesWin(score, k) {
    let count = 0;
    for (let i = 0; i < score.length; i++) {
        if (score[i] > score[i - 1]) {
            count++;
            if (count === k) return i;
        } else {
            count = 0;
        }
    }
    return -1;
}