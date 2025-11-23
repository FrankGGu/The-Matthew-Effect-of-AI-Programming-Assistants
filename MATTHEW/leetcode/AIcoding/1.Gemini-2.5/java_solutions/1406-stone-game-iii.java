class Solution {
    public String stoneGameIII(int[] stoneValue) {
        int n = stoneValue.length;
        // dp[i] stores the maximum score Alice can get relative to Bob,
        // if the game starts from index i.
        // We need n+3 to handle dp[i+1], dp[i+2], dp[i+3] without out-of-bounds
        // when i is near n-1, n-2, n-3.
        // dp[n], dp[n+1], dp[n+2] will be 0 as there are no stones left.
        int[] dp = new int[n + 3]; 

        // Iterate from the end of the stoneValue array backwards
        for (int i = n - 1; i >= 0; i--) {
            int maxDiff = Integer.MIN_VALUE;
            int currentStonesValue = 0;

            // Option 1: Alice takes 1 stone
            currentStonesValue += stoneValue[i];
            maxDiff = Math.max(maxDiff, currentStonesValue - dp[i + 1]);

            // Option 2: Alice takes 2 stones
            if (i + 1 < n) {
                currentStonesValue += stoneValue[i + 1];
                maxDiff = Math.max(maxDiff, currentStonesValue - dp[i + 2]);
            }

            // Option 3: Alice takes 3 stones
            if (i + 2 < n) {
                currentStonesValue += stoneValue[i + 2];
                maxDiff = Math.max(maxDiff, currentStonesValue - dp[i + 3]);
            }

            dp[i] = maxDiff;
        }

        // dp[0] contains the final score difference (Alice's score - Bob's score)
        if (dp[0] > 0) {
            return "Alice";
        } else if (dp[0] < 0) {
            return "Bob";
        } else {
            return "Tie";
        }
    }
}