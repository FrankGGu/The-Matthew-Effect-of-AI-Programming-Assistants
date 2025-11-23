var bestTeamScore = function(scores, ages) {
    const players = scores.map((score, index) => [ages[index], score]);
    players.sort((a, b) => a[0] - b[0] || b[1] - a[1]);

    const dp = Array(scores.length).fill(0);

    for (let i = 0; i < players.length; i++) {
        dp[i] = players[i][1];
        for (let j = 0; j < i; j++) {
            if (players[j][1] <= players[i][1]) {
                dp[i] = Math.max(dp[i], dp[j] + players[i][1]);
            }
        }
    }

    return Math.max(...dp);
};