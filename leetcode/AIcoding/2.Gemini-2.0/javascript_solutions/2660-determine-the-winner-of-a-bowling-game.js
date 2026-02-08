var isWinner = function(player1, player2) {
    const calculateScore = (player) => {
        let score = 0;
        for (let i = 0; i < player.length; i++) {
            if ((i > 0 && player[i - 1] === 10) || (i > 1 && player[i - 2] === 10)) {
                score += 2 * player[i];
            } else {
                score += player[i];
            }
        }
        return score;
    };

    const score1 = calculateScore(player1);
    const score2 = calculateScore(player2);

    if (score1 > score2) {
        return 1;
    } else if (score2 > score1) {
        return 2;
    } else {
        return 0;
    }
};