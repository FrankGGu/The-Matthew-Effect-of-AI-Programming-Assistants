impl Solution {
    pub fn can_reach(s: String, min_jump: i32, max_jump: i32) -> bool {
        let n = s.len();
        let s_chars: Vec<char> = s.chars().collect();

        let mut dp: Vec<bool> = vec![false; n];
        dp[0] = true;

        let mut prefix_sum: Vec<i32> = vec![0; n + 1];
        prefix_sum[1] = 1;

        for i in 1..n {
            if s_chars[i] == '0' {
                let k_min_val = i as i32 - max_jump;
                let k_max_val = i as i32 - min_jump;

                let actual_lower_bound_for_ps = k_min_val.max(0) as usize;
                let actual_upper_bound_for_ps_idx = (k_max_val + 1).max(0) as usize;

                if prefix_sum[actual_upper_bound_for_ps_idx] - prefix_sum[actual_lower_bound_for_ps] > 0 {
                    dp[i] = true;
                }
            }

            prefix_sum[i + 1] = prefix_sum[i] + (if dp[i] { 1 } else { 0 });
        }

        dp[n - 1]
    }
}