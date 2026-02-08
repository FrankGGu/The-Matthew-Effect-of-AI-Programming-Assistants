var bestTeamScore = function(scores, ages) {
    const n = scores.length;
    const players = [];
    for (let i = 0; i < n; i++) {
        players.push([ages[i], scores[i]]);
    }

    players.sort((a, b) => {
        if (a[0] !== b[0]) {
            return a[0] - b[0];
        } else {
            return a[1] - b[1];
        }
    });

    const dp = new Array(n).fill(0);
    let maxScore = 0;

    for (let i = 0; i < n; i++) {
        dp[i] = players[i][1];
        for (let j = 0; j < i; j++) {
            if (players[i][1] >= players[j][1]) {
                dp[i] = Math.max(dp[i], dp[j] + players[i][1]);
            }
        }
        maxScore = Math.max(maxScore, dp[i]);
    }

    return maxScore;
};