use std::cmp::min;

impl Solution {
    pub fn minimum_time(num_laps: i32, change_time: i32, tires: Vec<Vec<i32>>) -> i64 {
        let num_laps = num_laps as usize;
        let change_time = change_time as i64;

        // MAX_K_EXP is the maximum number of consecutive laps a tire with r > 1 might be used.
        // If f * (r^k - 1) / (r - 1) exceeds the total possible race time, it's not useful.
        // Max total time is roughly num_laps * (max_f + max_change_time) = 10^5 * (10^5 + 10^5) = 2 * 10^10.
        // For f=1, r=2, 2^k - 1 > 2*10^10 implies k > log2(2*10^10) approx 34.
        // A value like 60 is a very safe upper bound to cover all r > 1 cases without overflow issues.
        const MAX_K_EXP: usize = 60; 

        // min_consecutive_time[k] stores the minimum time to complete k consecutive laps
        // using a single tire, starting fresh.
        let mut min_consecutive_time: Vec<i64> = vec![i64::MAX; num_laps + 1];

        // min_f_r1 stores the minimum 'f' value among all tires with r = 1.
        let mut min_f_r1: i64 = i64::MAX;

        for tire in tires {
            let f = tire[0] as i64;
            let r = tire[1] as i64;

            if r == 1 {
                min_f_r1 = min(min_f_r1, f);
            }

            let mut current_lap_time = f;
            let mut current_total_time: i64 = 0;

            for k in 1..=num_laps {
                // Check for overflow before adding current_lap_time to current_total_time.
                if current_total_time > i64::MAX - current_lap_time {
                    current_total_time = i64::MAX; // Cap at effectively infinity
                } else {
                    current_total_time += current_lap_time;
                }

                min_consecutive_time[k] = min(min_consecutive_time[k], current_total_time);

                if r == 1 {
                    // For r=1, current_lap_time remains f. Loop continues up to num_laps.
                } else { // r > 1
                    // Check if current_lap_time * r would overflow.
                    // If current_lap_time is already very large, subsequent laps will be even more expensive.
                    if current_lap_time > i64::MAX / r {
                        current_lap_time = i64::MAX; // Cap at effectively infinity
                        break; // No need to calculate further for this tire
                    } else {
                        current_lap_time *= r;
                    }

                    // Optimization: for r > 1, after a certain number of laps (MAX_K_EXP),
                    // it's almost always better to change tires.
                    if k >= MAX_K_EXP {
                        break; 
                    }
                }
            }
        }

        // dp[i] = minimum time to finish i laps
        let mut dp: Vec<i64> = vec![i64::MAX; num_laps + 1];
        dp[0] = 0;

        // min_val_j_minus_j_min_f_r1 stores min(dp[j] - j * min_f_r1) for j in the current window.
        // This is used for the optimized DP transition for r=1 tires.
        let mut min_val_j_minus_j_min_f_r1: i64 = i64::MAX;
        if min_f_r1 != i64::MAX {
            min_val_j_minus_j_min_f_r1 = 0; // for j=0, dp[0] - 0 * min_f_r1 = 0
        }

        for i in 1..=num_laps {
            // Case 1: Use a tire for k laps, where k <= MAX_K_EXP.
            // This covers all r > 1 tires and some r=1 tires.
            for k in 1..=min(i, MAX_K_EXP) {
                let prev_dp_val = dp[i - k];
                if prev_dp_val == i64::MAX {
                    continue; // Cannot reach i-k laps
                }

                let mut segment_cost = min_consecutive_time[k];
                if segment_cost == i64::MAX {
                    continue; // This segment is unreachable
                }

                // Add change_time if this is not the first segment (i.e., i-k > 0)
                if i - k > 0 {
                    if segment_cost > i64::MAX - change_time {
                        segment_cost = i64::MAX; // Cap to prevent overflow
                    } else {
                        segment_cost += change_time;
                    }
                }

                if prev_dp_val != i64::MAX && segment_cost != i64::MAX {
                    if prev_dp_val > i64::MAX - segment_cost {
                        // Result would overflow, dp[i] remains i64::MAX or is updated by a smaller value
                    } else {
                        dp[i] = min(dp[i], prev_dp_val + segment_cost);
                    }
                }
            }

            // Case 2: Use a tire for k laps, where k > MAX_K_EXP.
            // This only makes sense for r=1 tires, where min_consecutive_time[k] = k * min_f_r1.
            if min_f_r1 != i64::MAX && i > MAX_K_EXP {
                // dp[i] = min(dp[j] + change_time + (i-j) * min_f_r1) for j < i - MAX_K_EXP
                // Rearranging: dp[i] = change_time + i * min_f_r1 + min(dp[j] - j * min_f_r1)
                // The min(dp[j] - j * min_f_r1) part is stored in min_val_j_minus_j_min_f_r1.

                if min_val_j_minus_j_min_f_r1 != i64::MAX {
                    let mut current_total = min_val_j_minus_j_min_f_r1;

                    // Add change_time
                    if current_total > i64::MAX - change_time {
                        current_total = i64::MAX;
                    } else {
                        current_total += change_time;
                    }

                    // Add i * min_f_r1
                    let i_min_f_r1_term;
                    let i_i64 = i as i64;
                    if i_i64 > i64::MAX / min_f_r1 { // Check for overflow
                        i_min_f_r1_term = i64::MAX;
                    } else {
                        i_min_f_r1_term = i_i64 * min_f_r1;
                    }

                    if current_total != i64::MAX && i_min_f_r1_term != i64::MAX {
                        if current_total > i64::MAX - i_min_f_r1_term {
                            current_total = i64::MAX;
                        } else {
                            current_total += i_min_f_r1_term;
                        }
                    } else {
                        current_total = i64::MAX;
                    }

                    dp[i] = min(dp[i], current_total);
                }
            }

            // Update min_val_j_minus_j_min_f_r1 for the next iteration.
            // The new j value entering the window for future minimum calculations is `i - MAX_K_EXP`.
            // This update needs to happen when `i - MAX_K_EXP` is a valid index, i.e., `i >= MAX_K_EXP`.
            if min_f_r1 != i64::MAX && i >= MAX_K_EXP {
                let j_idx = i - MAX_K_EXP;
                let mut val_j_idx = dp[j_idx];

                if val_j_idx != i64::MAX {
                    let j_idx_i64 = j_idx as i64;
                    let j_idx_min_f_r1_term;
                    if j_idx_i64 > i64::MAX / min_f_r1 { // Check for overflow
                        j_idx_min_f_r1_term = i64::MAX;
                    } else {
                        j_idx_min_f_r1_term = j_idx_i64 * min_f_r1;
                    }

                    if j_idx_min_f_r1_term == i64::MAX {
                        val_j_idx = i64::MAX;
                    } else {
                        val_j_idx -= j_idx_min_f_r1_term;
                    }
                }
                min_val_j_minus_j_min_f_r1 = min(min_val_j_minus_j_min_f_r1, val_j_idx);
            }
        }

        dp[num_laps]
    }
}