impl Solution {
    pub fn max_students(seats: Vec<String>) -> i32 {
        let m = seats.len();
        let n = seats[0].len();

        let seats_chars: Vec<Vec<char>> = seats.iter().map(|s| s.chars().collect()).collect();

        let mut prev_dp = vec![-1; 1 << n];

        let is_valid_row_mask = |mask: u16, row_idx: usize| -> bool {
            if (mask & (mask << 1)) != 0 {
                return false;
            }
            for col in 0..n {
                if ((mask >> col) & 1) == 1 && seats_chars[row_idx][col] == '#' {
                    return false;
                }
            }
            true
        };

        let is_compatible = |curr_mask: u16, prev_mask: u16| -> bool {
            if (curr_mask & (prev_mask << 1)) != 0 {
                return false;
            }
            if (curr_mask & (prev_mask >> 1)) != 0 {
                return false;
            }
            true
        };

        for mask in 0..(1 << n) {
            if is_valid_row_mask(mask, 0) {
                prev_dp[mask as usize] = mask.count_ones() as i32;
            }
        }

        for row_idx in 1..m {
            let mut curr_dp = vec![-1; 1 << n];
            for curr_mask in 0..(1 << n) {
                if !is_valid_row_mask(curr_mask, row_idx) {
                    continue;
                }
                for prev_mask in 0..(1 << n) {
                    if prev_dp[prev_mask as usize] == -1 {
                        continue;
                    }
                    if is_compatible(curr_mask, prev_mask) {
                        curr_dp[curr_mask as usize] = curr_dp[curr_mask as usize]
                            .max(prev_dp[prev_mask as usize] + curr_mask.count_ones() as i32);
                    }
                }
            }
            prev_dp = curr_dp;
        }

        prev_dp.into_iter().max().unwrap_or(0).max(0)
    }
}