impl Solution {
    pub fn num_ways(steps: i32, arr_len: i32) -> i32 {
        let modulo = 1_000_000_007;

        let max_pos = (steps as usize).min((arr_len - 1) as usize);

        let mut dp_prev: Vec<i32> = vec![0; max_pos + 1];
        let mut dp_curr: Vec<i32> = vec![0; max_pos + 1];

        dp_prev[0] = 1;

        for _s in 1..=steps as usize {
            for j in 0..=max_pos {
                let mut ways = 0;

                // Stay at current position (j)
                ways = (ways + dp_prev[j]) % modulo;

                // Move left to current position (j) from previous position (j+1)
                if j + 1 <= max_pos {
                    ways = (ways + dp_prev[j + 1]) % modulo;
                }

                // Move right to current position (j) from previous position (j-1)
                if j > 0 {
                    ways = (ways + dp_prev[j - 1]) % modulo;
                }

                dp_curr[j] = ways;
            }
            std::mem::swap(&mut dp_prev, &mut dp_curr);
        }

        dp_prev[0]
    }
}