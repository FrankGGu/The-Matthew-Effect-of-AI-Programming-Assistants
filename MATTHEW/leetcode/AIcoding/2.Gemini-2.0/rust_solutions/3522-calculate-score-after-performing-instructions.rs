impl Solution {
    pub fn calculate_score(s: String, k: i32) -> i64 {
        let n = s.len();
        let mut score: i64 = 0;
        let mut visited = vec![false; n];
        let s_bytes = s.as_bytes();

        for i in 0..n {
            if visited[i] {
                continue;
            }

            let mut j = i;
            let mut count = 0;
            while j < n && s_bytes[j] == s_bytes[i] && !visited[j] {
                visited[j] = true;
                count += 1;
                j += 1;
            }

            if count >= k {
                score += (count as i64) * (count as i64);
            }
        }

        score
    }
}