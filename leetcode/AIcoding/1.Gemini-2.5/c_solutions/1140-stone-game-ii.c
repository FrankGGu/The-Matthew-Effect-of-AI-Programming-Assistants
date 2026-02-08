#include <stdlib.h> // For malloc, free
#include <string.h> // For memset
#include <limits.h> // For INT_MIN

int max(int a, int b) {
    return a > b ? a : b;
}

int stoneGameII(int* piles, int pilesSize) {
    int n = pilesSize;

    // suffix_sum[i] stores sum of piles from index i to n-1
    // suffix_sum[n] will be 0 (no stones beyond index n-1)
    int* suffix_sum = (int*)malloc((n + 1) * sizeof(int));
    suffix_sum[n] = 0;
    for (int i = n - 1; i >= 0; i--) {
        suffix_sum[i] = suffix_sum[i+1] + piles[i];
    }

    // dp[i][m] stores the maximum stones the current player can get
    // starting from piles[i] with current M value m.
    // i: 0 to n-1 (index of the first remaining pile)
    // m: 1 to n (M can increase up to n, as X can be at most n)
    int** dp = (int**)malloc(n * sizeof(int*));
    for (int i = 0; i < n; i++) {
        dp[i] = (int*)malloc((n + 1) * sizeof(int));
    }

    // Fill dp table from bottom-up:
    // i from n-1 down to 0 (processing piles from end to start)
    // m from 1 up to n (M values)
    for (int i = n - 1; i >= 0; i--) {
        for (int m = 1; m <= n; m++) {
            // Base case: If the current player can take all remaining piles
            // This happens if the number of remaining piles (n - i) is less than or equal to 2*m.
            // In this scenario, the current player takes all `suffix_sum[i]` stones.
            if (i + 2 * m >= n) {
                dp[i][m] = suffix_sum[i];
            } else {
                // General case: Current player chooses x piles to maximize their score.
                // Stones are non-negative, so 0 is a valid lower bound for the maximum score.
                int max_stones_for_current_player = 0; 

                // Current player can take x piles, where 1 <= x <= 2*m.
                // Also, x cannot exceed the number of remaining piles (n - i).
                for (int x = 1; x <= 2 * m; x++) {
                    // If taking x piles would go beyond the end of the array, stop.
                    // This condition (i + x > n) is equivalent to x > n - i.
                    if (i + x > n) { 
                        break; 
                    }

                    // Current player takes x piles.
                    // Stones received by current player from these x piles: piles[i] + ... + piles[i+x-1]
                    // This sum is `suffix_sum[i] - suffix_sum[i+x]`.
                    // After current player takes x piles, the next player's turn starts from piles[i+x]
                    // with a new M value: `max(m, x)`.
                    // The next player will play optimally and get `dp[i+x][max(m, x)]` stones.
                    // The total stones available from piles[i+x] onwards is `suffix_sum[i+x]`.
                    // So, the current player gets `(suffix_sum[i+x] - dp[i+x][max(m, x)])` from the remaining piles.
                    // Total score for current player for this choice of x:
                    // `(suffix_sum[i] - suffix_sum[i+x]) + (suffix_sum[i+x] - dp[i+x][max(m, x)])`
                    // This simplifies to: `suffix_sum[i] - dp[i+x][max(m, x)]`.
                    int current_choice_score = suffix_sum[i] - dp[i+x][max(m, x)];

                    if (current_choice_score > max_stones_for_current_player) {
                        max_stones_for_current_player = current_choice_score;
                    }
                }
                dp[i][m] = max_stones_for_current_player;
            }
        }
    }

    // Alice starts at index 0 with M=1.
    int result = dp[0][1];

    // Free allocated memory
    free(suffix_sum);
    for (int i = 0; i < n; i++) {
        free(dp[i]);
    }
    free(dp);

    return result;
}