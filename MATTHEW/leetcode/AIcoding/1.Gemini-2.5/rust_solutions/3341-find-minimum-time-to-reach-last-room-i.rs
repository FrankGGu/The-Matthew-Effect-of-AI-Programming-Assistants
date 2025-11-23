impl Solution {
    pub fn find_minimum_time(rooms: Vec<Vec<i32>>, k: i32) -> i32 {
        let n = rooms.len();
        let k = k as usize;

        if n == 0 {
            return 0;
        }
        if n == 1 {
            // For room 0, we start at time 0.
            // We must wait until rooms[0][0] to enter, then clean for rooms[0][1].
            return (rooms[0][0] + rooms[0][1]).max(0);
        }

        // `dp[j]` stores the minimum time after processing the current room `i`,
        // having skipped exactly `j` rooms up to and including room `i`.
        // Initialize with a large value (infinity).
        let mut prev_dp = vec![i64::MAX; k + 1];
        let mut curr_dp = vec![i64::MAX; k + 1];

        // Base case: Processing Room 0 (i=0)
        // Option 1: Clean room 0 (0 skips)
        // Current time is 0. Wait until rooms[0][0], then clean.
        prev_dp[0] = (rooms[0][0] + rooms[0][1]) as i64;

        // Option 2: Skip room 0 (1 skip)
        // If we skip room 0, no cleaning time is spent. Time remains 0.
        if k >= 1 {
            prev_dp[1] = 0;
        }

        // Iterate for rooms 1 to n-1
        for i in 1..n {
            // Reset curr_dp for the current room 'i'
            for j in 0..=k {
                curr_dp[j] = i64::MAX;
            }

            // Calculate `curr_dp[j]` based on `prev_dp`
            // Iterate `j` from 0 to k for the current room `i`
            for j in 0..=k {
                // Option 1: Clean room `i`
                // This path comes from `prev_dp[j]` (meaning `j` skips were used up to room `i-1`).
                // Cleaning room `i` means we still use `j` skips up to room `i`.
                if prev_dp[j] != i64::MAX {
                    let time_to_arrive_at_i = prev_dp[j] + 1; // Travel from i-1 to i takes 1 unit
                    let enter_time = time_to_arrive_at_i.max(rooms[i][0] as i64);
                    let time_after_cleaning = enter_time + rooms[i][1] as i64;
                    curr_dp[j] = curr_dp[j].min(time_after_cleaning);
                }

                // Option 2: Skip room `i`
                // This path comes from `prev_dp[j-1]` (meaning `j-1` skips were used up to room `i-1`).
                // Skipping room `i` means we now use `j` skips up to room `i`.
                if j >= 1 && prev_dp[j - 1] != i64::MAX {
                    let time_after_skipping = prev_dp[j - 1] + 1; // Travel from i-1 to i, just pass room i
                    curr_dp[j] = curr_dp[j].min(time_after_skipping);
                }
            }

            // Move curr_dp to prev_dp for the next iteration
            prev_dp.copy_from_slice(&curr_dp);
        }

        // The answer is the minimum time to finish processing room n-1,
        // having skipped at most `k` rooms.
        let mut min_final_time = i64::MAX;
        for j in 0..=k {
            min_final_time = min_final_time.min(prev_dp[j]);
        }

        min_final_time as i32
    }
}