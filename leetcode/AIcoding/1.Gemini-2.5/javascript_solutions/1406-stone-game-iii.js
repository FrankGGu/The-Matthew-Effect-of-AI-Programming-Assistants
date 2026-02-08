var stoneGameIII = function(stones) {
    const n = stones.length;
    // dp[i] represents the maximum score difference (current player's score - opponent's score)
    // that the current player can achieve starting from stones[i].
    // dp[n] is 0, as there are no stones left, so the score difference is 0.
    const dp = new Array(n + 1).fill(0);

    // Iterate from the end of the stones array backwards
    for (let i = n - 1; i >= 0; i--) {
        let currentSum = 0;
        let maxDiff = -Infinity;

        // The current player can take 1, 2, or 3 stones
        for (let k = 0; k < 3; k++) {
            // Check if there are enough stones to take k+1 stones (i.e., stones[i] up to stones[i+k])
            if (i + k < n) {
                currentSum += stones[i + k];
                // The score for taking stones[i...i+k] is currentSum.
                // After taking these stones, it's the opponent's turn starting from stones[i+k+1].
                // The opponent will play optimally to maximize their score difference (dp[i+k+1]).
                // From the current player's perspective, this is a deduction.
                // So, the current player's score difference for this choice is currentSum - dp[i+k+1].
                maxDiff = Math.max(maxDiff, currentSum - dp[i + k + 1]);
            } else {
                // If there are fewer than k+1 stones remaining, we cannot take k+1 stones.
                // The loop will naturally terminate or the condition `i+k < n` will prevent further calculations.
                // No need for an explicit break here, as `i+k` will eventually exceed `n-1`.
            }
        }
        dp[i] = maxDiff;
    }

    // Alice is the first player, so we check the maximum score difference she can achieve starting from stones[0].
    if (dp[0] > 0) {
        return "Alice";
    } else if (dp[0] < 0) {
        return "Bob";
    } else {
        return "Tie";
    }
};