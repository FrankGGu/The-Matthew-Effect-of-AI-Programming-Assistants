use std::cmp::min;

impl Solution {
    pub fn min_number_of_semesters(n: i32, dependencies: Vec<Vec<i32>>, k: i32) -> i32 {
        let n = n as usize;
        let k = k as u32;

        // prereqs[i] stores a bitmask of courses that are prerequisites for course i.
        // Courses are 1-indexed in the problem, convert to 0-indexed.
        let mut prereqs: Vec<u16> = vec![0; n];
        for dep in dependencies {
            let u = dep[0] as usize - 1;
            let v = dep[1] as usize - 1;
            prereqs[v] |= (1 << u) as u16;
        }

        // dp[mask] stores the minimum number of semesters to complete the courses
        // represented by 'mask'.
        // Initialize with a value indicating infinity (n + 1 is sufficient as max semesters is n).
        let mut dp: Vec<u8> = vec![(n + 1) as u8; 1 << n];
        dp[0] = 0; // 0 semesters to complete 0 courses.

        // Iterate through all possible masks of completed courses.
        // 'mask' represents the set of courses completed *before* the current semester.
        for mask in 0..(1 << n) {
            if dp[mask] as usize > n { // If this state is unreachable, skip.
                continue;
            }

            // Find all courses that are available to be taken in the current semester.
            // A course `i` is available if:
            // 1. It's not yet in `mask` (not completed).
            // 2. All its prerequisites `prereqs[i]` are a subset of `mask` (already completed).
            let mut can_take_mask = 0;
            for i in 0..n {
                if (mask & (1 << i)) == 0 { // Course i is not completed
                    if (prereqs[i] & mask as u16) == prereqs[i] { // All prerequisites met
                        can_take_mask |= (1 << i);
                    }
                }
            }

            // If no courses can be taken, continue.
            if can_take_mask == 0 {
                continue;
            }

            // Iterate over all non-empty submasks of `can_take_mask`.
            // These `take_mask_iter` represent the courses chosen for the current semester.
            let mut take_mask_iter = can_take_mask;
            while take_mask_iter > 0 {
                // If the number of courses in `take_mask_iter` is within the limit `k`.
                if take_mask_iter.count_ones() <= k {
                    // Update the DP state for the new mask (current completed courses `mask` + `take_mask_iter`).
                    let next_mask = mask | take_mask_iter;
                    dp[next_mask] = min(dp[next_mask], dp[mask] + 1);
                }
                // Get the next submask.
                take_mask_iter = (take_mask_iter - 1) & can_take_mask;
            }
        }

        // The result is the minimum semesters to complete all courses, which is dp[(1 << n) - 1].
        dp[(1 << n) - 1] as i32
    }
}