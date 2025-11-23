#include <stdlib.h> // For qsort, abs
#include <limits.h> // For INT_MAX
#include <math.h>   // For fmin

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int minDistance(int* houses, int housesSize, int k) {
    // 1. Sort the houses array to simplify cost calculation for ranges.
    qsort(houses, housesSize, sizeof(int), compare);

    int n = housesSize;

    // 2. Precompute costs[i][j]: minimum cost to place 1 mailbox for houses[i] to houses[j].
    // The optimal position for a single mailbox serving houses[i] to houses[j] is at the median house.
    int costs[n][n];
    for (int i = 0; i < n; i++) {
        for (int j = i; j < n; j++) {
            int median_idx = i + (j - i) / 2;
            int median_val = houses[median_idx];
            int current_cost = 0;
            for (int p = i; p <= j; p++) {
                current_cost += abs(houses[p] - median_val);
            }
            costs[i][j] = current_cost;
        }
    }

    // 3. Dynamic Programming dp[m][i]: minimum cost to place 'm' mailboxes for the first 'i' houses
    // (i.e., houses[0] to houses[i-1]).
    // dp table size: (k+1) x (n+1)
    int dp[k + 1][n + 1];

    // Initialize dp table with a large value (INT_MAX) to represent unreachable states.
    for (int m = 0; m <= k; m++) {
        for (int i = 0; i <= n; i++) {
            dp[m][i] = INT_MAX;
        }
    }

    // Base case: 0 mailboxes for 0 houses has 0 cost.
    dp[0][0] = 0;

    // Fill the dp table
    for (int m = 1; m <= k; m++) { // Iterate through the number of mailboxes (1 to k)
        for (int i = 1; i <= n; i++) { // Iterate through the number of houses considered (1 to n)
            // If the number of mailboxes 'm' is greater than the number of houses 'i',
            // it's impossible to place 'm' mailboxes, so cost remains INT_MAX.
            if (m > i) {
                continue;
            }

            // If only 1 mailbox is to be placed for the first 'i' houses,
            // the cost is directly from the precomputed costs table.
            if (m == 1) {
                dp[m][i] = costs[0][i-1];
            } else {
                // To find dp[m][i], we consider placing the m-th mailbox for houses[j] to houses[i-1],
                // and the previous m-1 mailboxes for houses[0] to houses[j-1].
                // 'j' represents the count of houses for the first m-1 mailboxes (houses[0] to houses[j-1]).
                // 'j' must be at least 'm-1' to accommodate 'm-1' mailboxes.
                // 'j' must be less than 'i' because the last mailbox needs at least one house (houses[j] to houses[i-1]).
                for (int j = m - 1; j < i; j++) {
                    // Ensure that the state dp[m-1][j] is reachable (not INT_MAX)
                    if (dp[m-1][j] != INT_MAX) {
                        dp[m][i] = fmin(dp[m][i], (double)dp[m-1][j] + costs[j][i-1]);
                    }
                }
            }
        }
    }

    // The final answer is the minimum cost to place 'k' mailboxes for all 'n' houses.
    return dp[k][n];
}