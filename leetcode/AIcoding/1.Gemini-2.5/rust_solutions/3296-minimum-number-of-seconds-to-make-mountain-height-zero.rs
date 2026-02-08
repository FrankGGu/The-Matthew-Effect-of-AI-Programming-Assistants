impl Solution {
    pub fn minimum_time_to_make_mountain_height_zero(mountains: Vec<i32>) -> i32 {
        let n = mountains.len();

        let check = |t: i32| -> bool {
            for i in 0..n {
                let current_height = mountains[i];
                if current_height == 0 {
                    continue;
                }

                let diff_l = if i == 0 {
                    current_height
                } else {
                    current_height - mountains[i - 1]
                };

                let diff_r = if i == n - 1 {
                    current_height
                } else {
                    current_height - mountains[i + 1]
                };

                let d_i = diff_l.min(diff_r);

                if d_i <= 0 { // Not a peak, or not strictly higher than both neighbors
                    // Only manual reduction applies
                    if current_height > t {
                        return false;
                    }
                } else { // It's a peak
                    // num_erodes is the number of seconds mountain[i] actually erodes.
                    // It's limited by:
                    // 1. t: total seconds passed
                    // 2. d_i: how long it remains strictly higher than neighbors
                    // 3. current_height - 1: how long it remains > 1 (before manual reduction).
                    //    If current_height is 1, then current_height - 1 = 0, meaning it cannot erode.
                    //    If current_height is 2, then current_height - 1 = 1, meaning it can erode once.
                    let num_erodes_limit_by_height = current_height - 1;
                    let num_erodes = t.min(d_i).min(num_erodes_limit_by_height);

                    // Final height after t seconds of manual reduction and num_erodes seconds of erosion
                    if current_height - t - num_erodes > 0 {
                        return false;
                    }
                }
            }
            true
        };

        let mut low = 0;
        let mut high = *mountains.iter().max().unwrap_or(&0);
        let mut ans = high;

        while low <= high {
            let mid = low + (high - low) / 2;
            if check(mid) {
                ans = mid;
                high = mid - 1;
            } else {
                low = mid + 1;
            }
        }

        ans
    }
}