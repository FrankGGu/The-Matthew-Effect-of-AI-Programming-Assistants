var stoneGameV = function(stones) {
    const n = stones.length;

    const prefixSum = new Array(n + 1).fill(0);
    for (let i = 0; i < n; i++) {
        prefixSum[i + 1] = prefixSum[i] + stones[i];
    }

    // dp[i][j] stores the maximum score Alice can get from the subarray stones[i...j]
    const dp = Array(n).fill(0).map(() => Array(n).fill(0));

    // len is the length of the current subarray
    for (let len = 2; len <= n; len++) {
        // i is the starting index of the current subarray
        for (let i = 0; i <= n - len; i++) {
            // j is the ending index of the current subarray
            const j = i + len - 1;

            // Alice tries all possible split points k
            // k is the last index of the left part (stones[i...k])
            // The right part is stones[k+1...j]
            for (let k = i; k < j; k++) {
                const sumL = prefixSum[k + 1] - prefixSum[i];
                const sumR = prefixSum[j + 1] - prefixSum[k + 1];

                let currentSplitScore;
                let nextGameScore;

                if (sumL < sumR) {
                    currentSplitScore = sumL;
                    nextGameScore = dp[i][k]; // Bob chooses the left part to minimize Alice's future score
                } else if (sumR < sumL) {
                    currentSplitScore = sumR;
                    nextGameScore = dp[k + 1][j]; // Bob chooses the right part to minimize Alice's future score
                } else { // sumL === sumR
                    currentSplitScore = sumL; // Alice gets points for either part
                    // Bob chooses the part that leads to a minimum score for Alice
                    nextGameScore = Math.min(dp[i][k], dp[k + 1][j]);
                }

                // Alice wants to maximize her total score
                dp[i][j] = Math.max(dp[i][j], currentSplitScore + nextGameScore);
            }
        }
    }

    return dp[0][n - 1];
};