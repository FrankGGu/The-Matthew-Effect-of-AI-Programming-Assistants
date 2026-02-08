var minimumLevels = function(levels) {
    let n = levels.length;
    let totalHardLevels = 0;
    for (let i = 0; i < n; i++) {
        if (levels[i] === 1) {
            totalHardLevels++;
        }
    }

    let currentHardLevelsPlayed = 0;
    for (let k = 1; k <= n; k++) {
        // Points gained from playing the first k levels is simply k
        let playedPoints = k;

        // Update currentHardLevelsPlayed based on the (k-1)-th level (0-indexed)
        if (levels[k - 1] === 1) {
            currentHardLevelsPlayed++;
        }

        // Points lost from skipping the remaining n-k levels
        // This is the count of hard levels (1s) from index k to n-1
        // which is totalHardLevels - currentHardLevelsPlayed
        let skippedLoss = totalHardLevels - currentHardLevelsPlayed;

        if (playedPoints > skippedLoss) {
            return k;
        }
    }

    return n; // Should not reach here based on problem constraints
};