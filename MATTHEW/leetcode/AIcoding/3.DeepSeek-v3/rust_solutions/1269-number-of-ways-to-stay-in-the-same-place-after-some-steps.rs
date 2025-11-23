impl Solution {
    pub fn num_ways(steps: i32, arr_len: i32) -> i32 {
        let steps = steps as usize;
        let arr_len = arr_len as usize;
        let max_pos = std::cmp::min(steps / 2 + 1, arr_len);
        let mut dp_prev = vec![0; max_pos + 2];
        let mut dp_curr = vec![0; max_pos + 2];
        dp_prev[1] = 1;
        let mod_val = 1_000_000_007;

        for _ in 1..=steps {
            for pos in 1..=max_pos {
                dp_curr[pos] = (dp_prev[pos - 1] + dp_prev[pos] + dp_prev[pos + 1]) % mod_val;
            }
            std::mem::swap(&mut dp_prev, &mut dp_curr);
        }

        dp_prev[1] as i32
    }
}