#include <vector>
#include <algorithm>
#include <limits>

class Solution {
public:
    long long minFinishTime(int numLaps, int changeTime, std::vector<std::vector<int>>& tyres) {
        const long long LL_MAX = std::numeric_limits<long long>::max();
        const int K_EXP_MAX = 65; // Max laps for which r > 1 tyres are considered.
                                  // f * r^(k-1) can exceed LLONG_MAX around k=64 if f=1, r=2.
                                  // We stop at k=65 to be safe.

        // min_time_single_tyre[k] stores the minimum time to complete k laps using a single tyre (without changing).
        // This is precomputed for all k up to numLaps.
        std::vector<long long> min_time_single_tyre(numLaps + 1, LL_MAX);

        long long min_f_r1 = LL_MAX; // Minimum 'f' among tyres with r=1

        for (const auto& tyre : tyres) {
            long long f = tyre[0];
            long long r = tyre[1];

            if (r == 1) {
                min_f_r1 = std::min(min_f_r1, f);
                long long current_total_time = 0;
                for (int k = 1; k <= numLaps; ++k) {
                    if (LL_MAX - current_total_time < f) { // Check for overflow before adding f
                        current_total_time = LL_MAX;
                    } else {
                        current_total_time += f;
                    }
                    min_time_single_tyre[k] = std::min(min_time_single_tyre[k], current_total_time);
                }
            } else { // r > 1
                long long current_lap_time = f;
                long long total_time = 0;
                for (int k = 1; k <= numLaps; ++k) {
                    if (LL_MAX - total_time < current_lap_time) { // Check for total_time overflow
                        total_time = LL_MAX;
                    } else {
                        total_time += current_lap_time;
                    }
                    min_time_single_tyre[k] = std::min(min_time_single_tyre[k], total_time);

                    // If k exceeds K_EXP_MAX, or current_lap_time * r would overflow,
                    // we stop considering this tyre for more laps.
                    if (k >= K_EXP_MAX) {
                        break;
                    }
                    if (current_lap_time > LL_MAX / r) { // Check for current_lap_time * r overflow
                        break;
                    }
                    current_lap_time *= r;
                }
            }
        }

        // dp[i] = minimum time to finish i laps
        std::vector<long long> dp(numLaps + 1, LL_MAX);
        dp[0] = 0;

        // min_val_prefix_for_r1_opt stores min(dp[j] - min_f_r1 * j) for relevant j.
        long long min_val_prefix_for_r1_opt = LL_MAX;

        for (int i = 1; i <= numLaps; ++i) {
            // Option 1: Use a single tyre for k laps, where k is small (up to K_EXP_MAX)
            // This covers all tyres, including r=1 tyres for small k.
            for (int k = 1; k <= std::min(i, K_EXP_MAX); ++k) {
                if (dp[i - k] != LL_MAX && min_time_single_tyre[k] != LL_MAX) {
                    long long current_cost = dp[i - k];
                    if (LL_MAX - current_cost < changeTime) { // Check for overflow
                        current_cost = LL_MAX;
                    } else {
                        current_cost += changeTime;
                    }
                    if (current_cost != LL_MAX && LL_MAX - current_cost < min_time_single_tyre[k]) { // Check for overflow
                        current_cost = LL_MAX;
                    } else if (current_cost != LL_MAX) {
                        current_cost += min_time_single_tyre[k];
                    }
                    dp[i] = std::min(dp[i], current_cost);
                }
            }

            // Option 2: Use a tyre with r=1 for k laps, where k is large (k > K_EXP_MAX)
            // This optimization applies if there's at least one r=1 tyre.
            if (min_f_r1 != LL_MAX && i > K_EXP_MAX) {
                // We need to find min(dp[j] - min_f_r1 * j) for j = 0 to i - K_EXP_MAX - 1.
                // The j value that becomes available for prefix minimum at step i is i - K_EXP_MAX - 1.
                int j_to_consider = i - K_EXP_MAX - 1;

                if (dp[j_to_consider] != LL_MAX) {
                    long long val_to_add = dp[j_to_consider];
                    long long term_to_subtract = min_f_r1 * j_to_consider;
                    // Ensure subtraction does not lead to negative or overflow if val_to_add is large.
                    // Given dp[j] and min_f_r1*j are non-negative, this check is mainly for safety.
                    if (term_to_subtract > val_to_add) { 
                        val_to_add = LL_MAX; // Effectively invalidate this path.
                    } else {
                        val_to_add -= term_to_subtract;
                    }
                    min_val_prefix_for_r1_opt = std::min(min_val_prefix_for_r1_opt, val_to_add);
                }

                if (min_val_prefix_for_r1_opt != LL_MAX) {
                    long long current_cost = changeTime;
                    long long term_min_f_r1_i = min_f_r1 * i;

                    if (LL_MAX - current_cost < term_min_f_r1_i) { // Check for overflow
                        current_cost = LL_MAX;
                    } else {
                        current_cost += term_min_f_r1_i;
                    }

                    if (current_cost != LL_MAX && LL_MAX - current_cost < min_val_prefix_for_r1_opt) { // Check for overflow
                        current_cost = LL_MAX;
                    } else if (current_cost != LL_MAX) {
                        current_cost += min_val_prefix_for_r1_opt;
                    }
                    dp[i] = std::min(dp[i], current_cost);
                }
            }
        }

        return dp[numLaps];
    }
};