var bestTeamScore = function(scores, ages) {
    const players = scores.map((score, index) => ({ score, age: ages[index] }));
    players.sort((a, b) => a.age === b.age ? a.score - b.score : a.age - b.age);

    const dp = players.map(player => player.score);
    let maxScore = dp[0];

    for (let i = 1; i < players.length; i++) {
        for (let j = 0; j < i; j++) {
            if (players[j].score <= players[i].score) {
                dp[i] = Math.max(dp[i], dp[j] + players[i].score);
            }
        }
        maxScore = Math.max(maxScore, dp[i]);
    }

    return maxScore;
};