#include <limits.h>
#include <stdlib.h>
#include <stdio.h>

long long min(long long a, long long b) {
    return a < b ? a : b;
}

int paintWalls(int* cost, int costSize, int* time, int timeSize) {
    int n = costSize;

    // dp[i] will store the minimum cost to paint 'i' walls.
    // The maximum number of walls we might effectively need to pay for ourselves is 'n'.
    // The 'time' values can be up to 500. If we paint a wall with time[i],
    // it covers 1 wall (ourselves) + time[i] walls (free).
    // The "capacity" of our knapsack will be the number of walls we need to cover.
    // The maximum "coverage" we might need to track is 'n'.
    // If we paint wall 'i' ourselves, it costs cost[i] and covers 1 + time[i] walls.
    // We want to cover at least 'n' walls.
    // Let's define dp[j] as the minimum cost to paint 'j' walls (by us or free).
    // The maximum value for 'j' could be n + (n-1)*max_time.
    // However, we only care about covering *at least* n walls.
    // A more suitable state: dp[j] = minimum cost to achieve a "net time" of 'j'.
    // If we paint wall 'i' ourselves, it costs cost[i] and gives us 'time[i]' free walls.
    // It also consumes 1 wall slot that we must pay for.
    // So, we are effectively paying cost[i] to get 'time[i] - 1' additional free walls,
    // after accounting for the wall we painted ourselves.
    // This 'time[i] - 1' can be negative.
    // The range of this "net time" can be from -(n-1) to n * (max_time - 1).
    // Max net time: 500 * (500 - 1) = 500 * 499 = 249500.
    // This DP state is too large.

    // Let's use the standard 0/1 knapsack approach where:
    // Items: each wall `i`
    // "Weight" of item `i`: `time[i]` (time spent by us)
    // "Value" of item `i`: `cost[i]` (cost paid by us)
    // We need to select a subset of walls to paint ourselves.
    // Let `S` be the set of indices of walls we paint ourselves.
    // Total cost = `sum(cost[k] for k in S)`
    // Total walls painted by us = `|S|`
    // Total walls painted for free = `sum(time[k] for k in S)`
    // Total walls covered = `|S| + sum(time[k] for k in S)`
    // We need `|S| + sum(time[k] for k in S) >= n`.

    // Consider `dp[j]` as the minimum cost to paint `j` walls *ourselves*.
    // This means we have `j` walls covered by us.
    // The sum of times for these `j` walls is `T_j`.
    // We get `T_j` walls for free.
    // So, `j + T_j` walls are covered. We need `j + T_j >= n`.
    // This implies `T_j >= n - j`.
    // So, for each `j` (number of walls painted by us), we need to find the minimum cost
    // such that the sum of times for these `j` walls is at least `n - j`.
    // This is still complex.

    // The key insight for this problem is to consider the "net walls" gained.
    // If we paint wall `i` ourselves, we pay `cost[i]`.
    // We spend `time[i]` units of time. This means `time[i]` *other* walls are painted for free.
    // So, by painting wall `i` ourselves, we effectively cover `1 + time[i]` walls.
    // The problem is that if `1 + time[i]` is very large, the DP state `dp[j]` for `j` walls covered
    // would be too big.

    // Let's consider `dp[i]` as the minimum cost to paint `i` walls.
    // The capacity of our DP should be related to the number of walls we *need* to paint ourselves.
    // If we decide to paint `k` walls ourselves, then `n-k` walls must be painted by the free painter.
    // The total time we spend on these `k` walls must be at least `n-k`.
    // Let `dp[j]` be the minimum cost to achieve a total "time spent by us" of `j`.
    // The maximum possible `total time` is `n * max_time = 500 * 500 = 250000`. This is too large.

    // Let's use `dp[j]` as the minimum cost to paint `j` walls.
    // The maximum number of walls we might need to consider for `j` is `n`.
    // The trick is that if we paint wall `i` ourselves, we pay `cost[i]` and gain `time[i]` "free slots".
    // We also "use up" one wall slot by painting it ourselves.
    // So, the net effect is `time[i] - 1` free slots.
    // Let `dp[j]` be the minimum cost to get `j` "net free walls".
    // The range of `j` would be `-(n-1)` to `n * (max_time - 1)`. Still too large.

    // The standard solution for this problem uses DP where `dp[i]` is the minimum cost
    // to paint `i` walls *ourselves*, ensuring enough free walls are covered.
    // Let `dp[i]` be the minimum cost to paint `i` walls *ourselves*.
    // The total number of walls painted is `i` (by us) + `sum(time[k])` (free).
    // We need `i + sum(time[k]) >= n`.
    // This means `sum(time[k]) >= n - i`.
    // So, for each `i` walls we paint ourselves, we need to choose them such that their total time `T_i`
    // is at least `n - i`, and their total cost `C_i` is minimized.

    // This is a 0/1 knapsack problem.
    // Let `dp[j]` be the minimum cost to paint `j` walls.
    // The state `j` here represents the number of walls *that are NOT painted by us*.
    // So, `n - j` walls are painted by us.
    // If we paint wall `i` ourselves:
    //   It costs `cost[i]`.
    //   It takes `time[i]` time.
    //   This means `time[i]` walls are painted for free.
    //   So, if we were trying to paint `j` walls (not by us), now we need to paint `j - time[i]` walls (not by us).
    //   The number of walls we paint ourselves increases by 1.
    // The capacity of the knapsack is `n`. `dp[j]` = min cost to paint `j` walls by paid painter.
    // Initialize `dp` array of size `n+1`. `dp[0] = 0`, `dp[j] = infinity` for `j > 0`.
    // Iterate through each wall `i`:
    //   For `j` from `n` down to `0`:
    //     If `dp[j]` is not infinity:
    //       `new_j = max(0, j - time[i] - 1)` (because 1 wall is painted by us, time[i] walls are free)
    //       `dp[new_j] = min(dp[new_j], dp[j] + cost[i])`
    // This is still not quite right.

    // Let `dp[i]` be the minimum cost to paint `i` walls.
    // The number of walls to consider is `n`.
    // The maximum possible cost is `n * 10^6 = 500 * 10^6`.
    // The maximum possible time is `n * 500 = 250000`.

    // Let `dp[j]` be the minimum cost to paint `j` walls *ourselves*.
    // The number of walls we paint ourselves can be up to `n`.
    // The total time spent by us is `T_j`.
    // The total walls covered is `j + T_j`.
    // We need `j + T_j >= n`.
    // This means `T_j >= n - j`.

    // This is a 0/1 knapsack problem where:
    // Items: each wall `i`
    // "Weight" of item `i`: `time[i]` (time spent by us)
    // "Value" of item `i`: `cost[i]` (cost paid by us)
    // The "capacity" is not fixed, but rather a minimum `n - j` for each `j`.

    // Let `dp[j]` be the minimum cost to paint `j` units of "net time".
    // If we paint wall `i`: we pay `cost[i]`, and it contributes `time[i]` to our "time pool".
    // The `1` wall we paint ourselves is implicitly handled by the fact that we need to cover `n` walls.
    // The problem is equivalent to: we need to select a subset of walls `S` to paint ourselves.
    // The cost is `sum(cost[i] for i in S)`.
    // The number of walls covered is `|S| + sum(time[i] for i in S)`.
    // We need this sum to be at least `n`.

    // Let `dp[j]` be the minimum cost to paint `j` walls (by us + free).
    // The maximum value for `j` is `n`.
    // Initialize `dp[0] = 0`, `dp[j] = infinity` for `j > 0`.
    // For each wall `k` from `0` to `n-1`:
    //   For `j` from `n` down to `0`:
    //     `dp[min(n, j + 1 + time[k])] = min(dp[min(n, j + 1 + time[k])], dp[j] + cost[k])`
    // This is a common DP pattern for "at least X" problems.
    // `dp[j]` means minimum cost to cover *exactly* `j` walls.
    // If we add wall `k`, which covers `1 + time[k]` walls, and we already covered `j` walls,
    // then we can cover `j + 1 + time[k]` walls.
    // The state `dp[