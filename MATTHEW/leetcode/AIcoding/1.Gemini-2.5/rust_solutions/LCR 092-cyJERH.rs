impl Solution {
    pub fn min_flips_mono_incr(s: String) -> i32 {
        let mut dp0 = 0; // min flips for prefix ending with '0' (all '0's)
        let mut dp1 = 0; // min flips for prefix ending with '1' (0...01...1)

        for c in s.chars() {
            let prev_dp0 = dp0;
            let prev_dp1 = dp1;

            if c == '0' {
                // To maintain an all '0's prefix ending with '0', if current char is '0', no flip needed.
                dp0 = prev_dp0;
                // To maintain a '0...01...1' prefix ending with '1', if current char is '0', it must be flipped to '1'.
                // It can come from a previous all '0's prefix (prev_dp0) or a previous '0...01...1' prefix (prev_dp1).
                dp1 = prev_dp0.min(prev_dp1) + 1;
            } else { // c == '1'
                // To maintain an all '0's prefix ending with '0', if current char is '1', it must be flipped to '0'.
                dp0 = prev_dp0 + 1;
                // To maintain a '0...01...1' prefix ending with '1', if current char is '1', no flip needed.
                // It can come from a previous all '0's prefix (prev_dp0) or a previous '0...01...1' prefix (prev_dp1).
                dp1 = prev_dp0.min(prev_dp1);
            }
        }

        dp0.min(dp1)
    }
}