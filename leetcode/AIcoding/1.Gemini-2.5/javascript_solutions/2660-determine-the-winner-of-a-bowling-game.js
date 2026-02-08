var determineTheWinner = function(player1, player2) {
    const calculateScore = (player) => {
        let totalScore = 0;
        const n = player.length;
        for (let i = 0; i < n; i++) {
            let currentPins = player[i];
            let effectivePins = currentPins;

            if (i > 0 && player[i - 1] === 10) {
                effectivePins *= 2;
            } else if (i > 1 && player[i - 2] === 10) {
                effectivePins *= 2;
            }
            totalScore += effectivePins;
        }
        return totalScore;
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