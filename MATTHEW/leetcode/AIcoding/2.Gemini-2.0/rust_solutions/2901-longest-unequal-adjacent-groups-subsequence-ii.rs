impl Solution {
    pub fn longest_unequal_adjacent_groups_subsequence(words: Vec<String>, groups: Vec<i32>) -> Vec<String> {
        let n = words.len();
        let mut dp = vec![0; n];
        let mut prev = vec![-1; n];
        let mut max_len = 0;
        let mut end_index = -1;

        for i in 0..n {
            dp[i] = 1;
            prev[i] = -1;
            for j in 0..i {
                if groups[i] != groups[j] && words[i] != words[j] && dp[j] + 1 > dp[i] {
                    dp[i] = dp[j] + 1;
                    prev[i] = j as i32;
                }
            }

            if dp[i] > max_len {
                max_len = dp[i];
                end_index = i as i32;
            }
        }

        let mut result = Vec::new();
        let mut current = end_index;

        while current != -1 {
            result.push(words[current as usize].clone());
            current = prev[current as usize];
        }

        result.reverse();
        result
    }
}