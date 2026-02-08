package main

import "math"

func countNonDecreasingSubarrays(nums []int, k int) int64 {
    n := len(nums)
    if n == 0 {
        return 0
    }

    // dp[i][j][state] stores (max_total_score, length_of_nd_segment_ending_at_i)
    // state 0: nums[i] was not changed
    // state 1: nums[i] was changed
    // Initialize with -1 to indicate invalid/unreachable states
    type state struct {
        score  int64
        length int64
    }

    dp := make([][][]state, n)
    for i := range dp {
        dp[i] = make([][]state, k+1)
        for j := range dp[i] {
            dp[i][j] = make([]state, 2)
            dp[i][j][0] = state{-1, -1}
            dp[i][j][1] = state{-1, -1}
        }
    }

    // Base case for i = 0 (first element)
    // nums[0] not changed: contributes 1 to score (subarray [nums[0]]), length 1
    dp[0][0][0] = state{1, 1}
    // nums[0] changed: costs 1 operation, contributes 1 to score, length 1
    if k >= 1 {
        dp[0][1][1] = state{1, 1}
    }

    for i := 1; i < n; i++ {
        for j := 0; j <= k; j++ {
            // Calculate dp[i][j][0] (nums[i] not changed)
            // Option 1: nums[i-1] was not changed (dp[i-1][j][0])
            prev_s0_unchanged, prev_l0_unchanged := dp[i-1][j][0].score, dp[i-1][j][0].length
            if prev_s0_unchanged != -1 { // If previous state is valid
                cur_len := int64(1)
                if nums[i-1] <= nums[i] { // If original values are non-decreasing
                    cur_len = prev_l0_unchanged + 1
                }
                current_total_score := prev_s0_unchanged + cur_len

                if current_total_score > dp[i][j][0].score {
                    dp[i][j][0] = state{current_total_score, cur_len}
                } else if current_total_score == dp[i][j][0].score {
                    dp[i][j][0].length = max(dp[i][j][0].length, cur_len)
                }
            }

            // Option 2: nums[i-1] was changed (dp[i-1][j][1])
            prev_s1_changed, prev_l1_changed := dp[i-1][j][1].score, dp[i-1][j][1].length
            if prev_s1_changed != -1 { // If previous state is valid
                // If nums[i-1] was changed, we can assume nums'[i-1] can be set to a value <= nums[i]
                // to extend the non-decreasing segment. This makes nums'[i-1] <= nums'[i] (since nums'[i] is nums[i]).
                cur_len := prev_l1_changed + 1
                current_total_score := prev_s1_changed + cur_len

                if current_total_score > dp[i][j][0].score {
                    dp[i][j][0] = state{current_total_score, cur_len}
                } else if current_total_score == dp[i][j][0].score {
                    dp[i][j][0].length = max(dp[i][j][0].length, cur_len)
                }
            }

            // Calculate dp[i][j][1] (nums[i] changed, costs 1 operation)
            if j > 0 { // Check if we have operations left to change nums[i]
                // Option 1: nums[i-1] was not changed (dp[i-1][j-1][0])
                prev_s0_ops_unchanged, prev_l0_ops_unchanged := dp[i-1][j-1][0].score, dp[i-1][j-1][0].length
                if prev_s0_ops_unchanged != -1 { // If previous state is valid
                    // If nums[i] is changed, we can assume nums'[i] can be set to a value >= nums'[i-1]
                    // to extend the non-decreasing segment. (nums'[i-1] is nums[i-1] here).
                    cur_len := prev_l0_ops_unchanged + 1
                    current_total_score := prev_s0_ops_unchanged + cur_len

                    if current_total_score > dp[i][j][1].score {
                        dp[i][j][1] = state{current_total_score, cur_len}
                    } else if current_total_score == dp[i][j][1].score {
                        dp[i][j][1].length = max(dp[i][j][1].length, cur_len)
                    }
                }

                // Option 2: nums[i-1] was changed (dp[i-1][j-1][1])
                prev_s1_ops_changed, prev_l1_ops_changed := dp[i-1][j-1][1].score, dp[i-1][j-1][1].length
                if prev_s1_ops_changed != -1 { // If previous state is valid
                    // If nums[i] is changed, we can assume nums'[i] can be set to a value >= nums'[i-1]
                    // to extend the non-decreasing segment. (Both nums[i-1] and nums[i] are changed).
                    cur_len := prev_l1_ops_changed + 1
                    current_total_score := prev_s1_ops_changed + cur_len

                    if current_total_score > dp[i][j][1].score {
                        dp[i][j][1] = state{current_total_score, cur_len}
                    } else if current_total_score == dp[i][j][1].score {
                        dp[i][j][1].length = max(dp[i][j][1].length, cur_len)
                    }
                }
            }
        }
    }

    maxScore := int64(0)
    for j := 0; j <= k; j++ {
        if dp[n-1][j][0].score != -1 {
            maxScore = max(maxScore, dp[n-1][j][0].score)
        }
        if dp[n-1][j][1].score != -1 {
            maxScore = max(maxScore, dp[n-1][j][1].score)
        }
    }

    return maxScore
}

func max(a, b int64) int64 {
    if a > b {
        return a
    }
    return b
}