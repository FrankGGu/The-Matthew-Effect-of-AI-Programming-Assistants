var bestTeamWithNoConflicts = function(scores, ages) {
    const n = scores.length;
    const players = [];

    for (let i = 0; i < n; i++) {
        players.push([ages[i], scores[i]]);
    }

    // Sort players primarily by age in ascending order.
    // If ages are equal, sort by score in ascending order.
    // This sorting strategy is crucial:
    // 1. Ensures that when considering player_i, all players_j with age_j <= age_i are already processed.
    // 2. For players of the same age, sorting by score ascending simplifies the conflict check.
    //    If age_j == age_i, they never conflict. By sorting score ascending, we ensure score_j <= score_i.
    //    This allows us to use a single condition (score_j <= score_i) for both age_j < age_i and age_j == age_i.
    players.sort((a, b) => {
        if (a[0] !== b[0]) {
            return a[0] - b[0]; // Sort by age ascending
        }
        return a[1] - b[1]; // If ages are equal, sort by score ascending
    });

    // dp[i] will store the maximum score of a team ending with players[i].
    const dp = new Array(n).fill(0);
    let maxTotalScore = 0;

    for (let i = 0; i < n; i++) {
        // A team can always consist of just the current player.
        dp[i] = players[i][1]; 

        // Check previous players (j < i) to see if they can be part of a team with players[i].
        for (let j = 0; j < i; j++) {
            // If players[j]'s score is less than or equal to players[i]'s score,
            // they can be in the same team without conflict.
            // (Because players are sorted by age, age_j <= age_i is guaranteed.
            // If age_j < age_i, then score_j <= score_i prevents conflict.
            // If age_j == age_i, they don't conflict regardless of scores, and score_j <= score_i is guaranteed by secondary sort.)
            if (players[j][1] <= players[i][1]) {
                dp[i] = Math.max(dp[i], dp[j] + players[i][1]);
            }
        }
        // Update the overall maximum team score found so far.
        maxTotalScore = Math.max(maxTotalScore, dp[i]);
    }

    return maxTotalScore;
};