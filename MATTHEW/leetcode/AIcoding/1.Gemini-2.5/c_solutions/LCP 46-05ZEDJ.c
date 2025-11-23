#include <stdio.h>
#include <stdlib.h>
#include <limits.h> // For LLONG_MAX
#include <float.h>  // For DBL_MAX

#define MAX_VOL_I 1000000

#define MAX_DP_INDEX (2 * MAX_VOL_I)

long long dp[MAX_DP_INDEX + 1]; // dp array to store min cost for exactly j volunteers

long long min(long long a, long long b) {
    return a < b ? a : b;
}

long long minCostToPurchase(long long target_volunteers, long long v_eff, long long c_eff) {
    if (target_volunteers <= MAX_DP_INDEX) {
        // If target_volunteers is within DP table range, find min cost for at least target_volunteers
        long long current_min_purchase_cost = LLONG_MAX;
        for (long long j = target_volunteers; j <= MAX_DP_INDEX; ++j) {
            current_min_purchase_cost = min(current_min_purchase_cost, dp[j]);
        }
        return current_min_purchase_cost;
    } else {
        // If target_volunteers is larger than DP table range,
        // use DP table for smaller amounts and greedy for the large remainder.
        long long current_min_purchase_cost = LLONG_MAX;
        for (long long j = 0; j <= MAX_DP_INDEX; ++j) {
            if (dp[j] == LLONG_MAX) continue; // Cannot reach 'j' volunteers

            long long remaining_volunteers = target_volunteers - j;
            long long cost_from_greedy;

            if (remaining_volunteers <= 0) { // dp[j] already covers target_volunteers or more
                cost_from_greedy = 0;
            } else {
                // Use the most efficient type for the remaining volunteers
                // ceil(remaining_volunteers / v_eff)
                long long needed_units = (remaining_volunteers + v_eff - 1) / v_eff;
                cost_from_greedy = needed_units * c_eff;
            }

            // Check for overflow before adding dp[j] and cost_from_greedy
            if (dp[j] > LLONG_MAX - cost_from_greedy) {
                // This path would result in an overflow, effectively infinite cost, so skip.
                continue;
            }
            current_min_purchase_cost = min(current_min_purchase_cost, dp[j] + cost_from_greedy);
        }
        return current_min_purchase_cost;
    }
}

long long minimumCost(long long n, int m, int* volunteers, int* cost, long long inc) {
    // Initialize DP table for direct purchases
    for (int i = 0; i <= MAX_DP_INDEX; ++i) {
        dp[i] = LLONG_MAX;
    }
    dp[0] = 0; // 0 volunteers cost 0

    // Find the most efficient volunteer type (minimum cost/volunteer ratio)
    long long v_eff = 0;
    long long c_eff = 0;
    double min_ratio = DBL_MAX;

    for (int i = 0; i < m; ++i) {
        long long v = volunteers[i];
        long long c = cost[i];

        // Update most efficient type
        if ((double)c / v < min_ratio) {
            min_ratio = (double)c / v;
            v_eff = v;
            c_eff = c;
        }

        // Populate DP table using current type (unbounded knapsack)
        for (int j = (int)v; j <= MAX_DP_INDEX; ++j) {
            if (dp[j - v] != LLONG_MAX) { // If dp[j-v] is reachable
                dp[j] = min(dp[j], dp[j - v] + c);
            }
        }
    }

    long long min_total_cost = LLONG_MAX;

    // Iterate through possible number of doubling operations (k)
    // k can go up to ~60 for 1LL << k without overflow.
    // For n=10^9, 2^k will exceed n around k=30, making V_k=1.
    // Looping up to k=60 covers all practical scenarios.
    for (int k = 0; k <= 60; ++k) {
        long long current_doubles_cost;
        // Check for overflow before calculating k * inc
        if (inc > 0 && k > LLONG_MAX / inc) {
            current_doubles_cost = LLONG_MAX; // Cost would overflow, treat as infinite
        } else {
            current_doubles_cost = (long long)k * inc;
        }

        if (current_doubles_cost == LLONG_MAX) {
            // If doubling cost already overflowed, further k will also overflow or be larger.
            // No better solution can be found with more doublings.
            break; 
        }

        long long power_of_2_k = (1LL << k);
        // Calculate target volunteers needed before doubling: V_k = ceil(n / 2^k)
        // This handles positive integer ceil division correctly.
        long long V_k = (n + power_of_2_k - 1) / power_of_2_k;

        long long cost_for_V_k_purchase = minCostToPurchase(V_k, v_eff, c_eff);

        if (cost_for_V_k_purchase != LLONG_MAX) {
            // Check for overflow before adding purchase cost and doubling cost
            if (current_doubles_cost > LLONG_MAX - cost_for_V_k_purchase) {
                // This path would result in an overflow, skip. min_total_cost remains unchanged.
            } else {
                min_total_cost = min(min_total_cost, cost_for_V_k_purchase + current_doubles_cost);
            }
        }
    }

    return min_total_cost;
}