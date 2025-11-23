impl Solution {
    pub fn color_the_grid(m: i32, n: i32) -> i32 {
        let m = m as usize;
        let n = n as usize;
        let mod_num = 1_000_000_007;

        let mut dp = vec![vec![0; 3]; m];
        for i in 0..3 {
            dp[0][i] = 1;
        }

        for i in 1..m {
            for j in 0..3 {
                dp[i][j] = (dp[i-1][(j+1)%3] + dp[i-1][(j+2)%3]) % mod_num;
            }
        }

        let mut total = 0;
        for &num in &dp[m-1] {
            total = (total + num) % mod_num;
        }

        if n == 1 {
            return total;
        }

        let mut transitions = std::collections::HashMap::new();
        let mut valid_states = Vec::new();

        for a in 0..3 {
            for b in 0..3 {
                if a != b {
                    valid_states.push((a, b));
                }
            }
        }

        for &(a1, b1) in &valid_states {
            for &(a2, b2) in &valid_states {
                if a1 != a2 && b1 != b2 {
                    transitions.entry((a1, b1)).or_insert_with(Vec::new).push((a2, b2));
                }
            }
        }

        let mut state_counts = std::collections::HashMap::new();
        for &(a, b) in &valid_states {
            let cnt = (dp[m-1][a] * dp[m-1][b]) % mod_num;
            *state_counts.entry((a, b)).or_insert(0) = cnt;
        }

        for _ in 2..n {
            let mut new_state_counts = std::collections::HashMap::new();
            for (&state, &cnt) in &state_counts {
                if let Some(next_states) = transitions.get(&state) {
                    for &next_state in next_states {
                        *new_state_counts.entry(next_state).or_insert(0) = 
                            (new_state_counts.get(&next_state).unwrap_or(&0) + cnt) % mod_num;
                    }
                }
            }
            state_counts = new_state_counts;
        }

        let mut result = 0;
        for &cnt in state_counts.values() {
            result = (result + cnt) % mod_num;
        }
        result
    }
}