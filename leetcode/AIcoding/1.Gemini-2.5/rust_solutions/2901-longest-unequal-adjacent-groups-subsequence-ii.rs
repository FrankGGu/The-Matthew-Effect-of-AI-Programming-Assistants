impl Solution {
    pub fn get_longest_unequal_adjacent_groups_subsequence(groups: Vec<i32>, words: Vec<String>) -> Vec<String> {
        let n = groups.len();
        if n == 0 {
            return Vec::new();
        }

        let mut dp = vec![1; n];
        let mut prev_idx = vec![-1; n];

        for i in 0..n {
            for j in 0..i {
                if groups[j] != groups[i] {
                    if dp[j] + 1 > dp[i] {
                        dp[i] = dp[j] + 1;
                        prev_idx[i] = j as i32;
                    }
                }
            }
        }

        let mut max_len = 0;
        let mut end_idx = -1;

        for i in 0..n {
            if dp[i] > max_len {
                max_len = dp[i];
                end_idx = i as i32;
            }
        }

        let mut result_subsequence = Vec::new();
        let mut current_idx = end_idx;

        while current_idx != -1 {
            result_subsequence.push(words[current_idx as usize].clone());
            current_idx = prev_idx[current_idx as usize];
        }

        result_subsequence.reverse();
        result_subsequence
    }
}