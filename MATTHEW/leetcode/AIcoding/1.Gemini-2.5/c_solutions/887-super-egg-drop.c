int superEggDrop(int k, int n) {
    // dp[e][m] represents the maximum number of floors that can be checked
    // with 'e' eggs and 'm' moves.
    // We want to find the minimum 'm' such that dp[k][m] >= n.

    // The maximum number of eggs is 'k'.
    // The maximum number of moves can be 'n' (in the worst case, with 1 egg).
    // So, the dp table dimensions will be (k+1) x (n+1).
    int dp[k + 1][n + 1];

    // Initialize dp table to 0.
    // dp[e][0] = 0 (0 moves, 0 floors checked)
    // dp[0][m] = 0 (0 eggs, 0 floors checked)
    for (int i = 0; i <= k; i++) {
        for (int j = 0; j <= n; j++) {
            dp[i][j] = 0;
        }
    }

    // Iterate through the number of moves 'm'
    // 'm' can range from 1 up to 'n'
    for (int m = 1; m <= n; m++) {
        // Iterate through the number of eggs 'e'
        // 'e' can range from 1 up to 'k'
        for (int e = 1; e <= k; e++) {
            // The recurrence relation for dp[e][m]:
            // If we make a drop from a certain floor:
            // 1. The egg breaks: We have 'e-1' eggs and 'm-1' moves left.
            //    We can check dp[e-1][m-1] floors below the current drop floor.
            // 2. The egg doesn't break: We have 'e' eggs and 'm-1' moves left.
            //    We can check dp[e][m-1] floors above the current drop floor.
            // The '1' accounts for the current floor itself.
            dp[e][m] = 1 + dp[e-1][m-1] + dp[e][m-1];

            // If with 'k' eggs and 'm' moves, we can cover 'n' floors,
            // then 'm' is the minimum number of moves required.
            // We return 'm' as soon as this condition is met for 'k' eggs,
            // because we are iterating 'm' in increasing order.
            if (e == k && dp[e][m] >= n) {
                return m;
            }
        }
        // This check is equivalent to the one inside the loop when e == k,
        // but ensures we check after all eggs for the current 'm' are processed.
        // It's a slight optimization to return early.
        if (dp[k][m] >= n) {
            return m;
        }
    }

    // This line should theoretically not be reached for valid inputs (n >= 1).
    // It's a fallback in case the loop completes without finding a solution,
    // which would imply n > dp[k][n] (max floors with k eggs and n moves).
    return n; 
}