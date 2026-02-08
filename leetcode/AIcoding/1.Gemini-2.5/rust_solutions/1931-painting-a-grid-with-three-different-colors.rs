impl Solution {
    pub fn paint_grid(m: i32, n: i32) -> i32 {
        const MOD: i64 = 1_000_000_007;

        let mut all_patterns: Vec<Vec<i32>> = Vec::new();

        fn generate_patterns_recursive(
            m: i32,
            row: i32,
            current_pattern: &mut Vec<i32>,
            all_patterns: &mut Vec<Vec<i32>>,
        ) {
            if row == m {
                all_patterns.push(current_pattern.clone());
                return;
            }

            for color in 0..3 { // Colors 0, 1, 2
                if row > 0 && current_pattern[(row - 1) as usize] == color {
                    continue; // Adjacent cells in the same column must have different colors
                }
                current_pattern.push(color);
                generate_patterns_recursive(m, row + 1, current_pattern, all_patterns);
                current_pattern.pop();
            }
        }

        generate_patterns_recursive(m, 0, &mut Vec::new(), &mut all_patterns);

        let num_patterns = all_patterns.len();

        fn is_compatible(p1: &[i32], p2: &[i32]) -> bool {
            for i in 0..p1.len() {
                if p1[i] == p2[i] {
                    return false; // Cells at the same row in adjacent columns must have different colors
                }
            }
            true
        }

        let mut dp_prev: Vec<i64> = vec![1; num_patterns]; // For the first column, all valid patterns are possible once

        for _col in 1..n { // Iterate for n-1 more columns
            let mut dp_curr: Vec<i64> = vec![0; num_patterns];
            for i in 0..num_patterns { // current_pattern_idx
                for j in 0..num_patterns { // prev_pattern_idx
                    if is_compatible(&all_patterns[i], &all_patterns[j]) {
                        dp_curr[i] = (dp_curr[i] + dp_prev[j]) % MOD;
                    }
                }
            }
            dp_prev = dp_curr;
        }

        let mut total_ways: i64 = 0;
        for count in dp_prev {
            total_ways = (total_ways + count) % MOD;
        }

        total_ways as i32
    }
}