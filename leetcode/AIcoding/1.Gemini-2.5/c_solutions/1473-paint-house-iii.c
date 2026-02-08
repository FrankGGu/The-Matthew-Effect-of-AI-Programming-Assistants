#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

#define INF 1000000001LL * 101

long long min(long long a, long long b) {
    return a < b ? a : b;
}

int paintHouseIII(int* houses, int housesSize, int n, int* cost_row_ptr, int cost_col_size, int target) {
    // housesSize is m (number of houses)
    // n is n (number of colors)
    // cost_row_ptr is a flattened 2D array, cost[i][j] = cost_row_ptr[i * cost_col_size + j]
    // target is the target number of neighborhoods

    // dp[i][j][k] represents the minimum cost to paint houses from 0 to i,
    // such that house i has color j (0-indexed, so actual color is j+1),
    // and there are k neighborhoods among houses 0 to i.
    long long dp[housesSize][n][target + 1];

    // Initialize dp table with INF
    for (int i = 0; i < housesSize; ++i) {
        for (int j = 0; j < n; ++j) {
            for (int k = 0; k <= target; ++k) {
                dp[i][j][k] = INF;
            }
        }
    }

    // Base case: Painting the first house (house 0)
    for (int c = 0; c < n; ++c) { // c is the 0-indexed color
        if (houses[0] == 0) { // House 0 is not pre-painted
            dp[0][c][1] = (long long)cost_row_ptr[0 * cost_col_size + c];
        } else if (houses[0] == c + 1) { // House 0 is pre-painted with color c+1
            dp[0][c][1] = 0;
        }
        // If houses[0] is pre-painted with a different color, dp[0][c][1] remains INF,
        // indicating this state is impossible.
    }

    // Fill the dp table for houses from 1 to housesSize - 1
    for (int i = 1; i < housesSize; ++i) {
        for (int k = 1; k <= target; ++k) { // Iterate through possible number of neighborhoods
            for (int currentColor = 0; currentColor < n; ++currentColor) { // Iterate through possible colors for house i

                long long currentPaintCost = 0;
                if (houses[i] != 0) { // House i is pre-painted
                    if (houses[i] != currentColor + 1) {
                        // If the pre-painted color of house i does not match currentColor,
                        // this state is invalid. dp[i][currentColor][k] remains INF.
                        continue;
                    }
                    // If houses[i] == currentColor + 1, the cost to paint is 0 as it's already done.
                } else { // House i is not pre-painted
                    currentPaintCost = (long long)cost_row_ptr[i * cost_col_size + currentColor];
                }

                // Consider the previous house (i-1) to determine the cost and neighborhood count
                for (int prevColor = 0; prevColor < n; ++prevColor) { // Iterate through possible colors for house i-1
                    if (currentColor == prevColor) {
                        // Case 1: House i has the same color as house i-1.
                        // This means they belong to the same neighborhood.
                        // The number of neighborhoods 'k' remains the same as for house i-1.
                        if (dp[i-1][prevColor][k] != INF) {
                            dp[i][currentColor][k] = min(dp[i][currentColor][k], dp[i-1][prevColor][k] + currentPaintCost);
                        }
                    } else {
                        // Case 2: House i has a different color than house i-1.
                        // This creates a new neighborhood.
                        // So, house i-1 must have formed k-1 neighborhoods.
                        if (k > 1 && dp[i-1][prevColor][k-1] != INF) {
                            dp[i][currentColor][k] = min(dp[i][currentColor][k], dp[i-1][prevColor][k-1] + currentPaintCost);
                        }
                    }
                }
            }
        }
    }

    // After filling the DP table, find the minimum cost among all possible colors for the last house
    long long minTotalCost = INF;
    for (int c = 0; c < n; ++c) {
        minTotalCost = min(minTotalCost, dp[housesSize - 1][c][target]);
    }

    // If minTotalCost is still INF, it means it's impossible to achieve the target neighborhoods.
    // Otherwise, return the minimum cost.
    return (minTotalCost == INF) ? -1 : (int)minTotalCost;
}