impl Solution {
    pub fn get_words_in_longest_sequence(n: i32, words: Vec<String>, groups: Vec<i32>) -> Vec<String> {
        let n = n as usize;
        let mut dp = vec![1; n];
        let mut prev = vec![n; n];
        let mut max_len = 1;
        let mut max_idx = 0;

        for i in 1..n {
            for j in 0..i {
                if groups[i] != groups[j] && words[i].len() == words[j].len() {
                    let mut diff = 0;
                    for (a, b) in words[i].chars().zip(words[j].chars()) {
                        if a != b {
                            diff += 1;
                        }
                        if diff > 1 {
                            break;
                        }
                    }
                    if diff == 1 && dp[i] < dp[j] + 1 {
                        dp[i] = dp[j] + 1;
                        prev[i] = j;
                    }
                }
            }
            if dp[i] > max_len {
                max_len = dp[i];
                max_idx = i;
            }
        }

        let mut res = Vec::new();
        let mut idx = max_idx;
        while idx != n {
            res.push(words[idx].clone());
            idx = prev[idx];
        }
        res.reverse();
        res
    }
}