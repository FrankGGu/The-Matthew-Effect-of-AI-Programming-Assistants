impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn is_interleave(s1: String, s2: String, s3: String) -> bool {
        if s1.len() + s2.len() != s3.len() {
            return false;
        }

        let (s1, s2, s3) = (s1.as_bytes(), s2.as_bytes(), s3.as_bytes());
        let mut queue = VecDeque::new();
        let mut visited = vec![vec![false; s2.len() + 1]; s1.len() + 1];

        queue.push_back((0, 0));
        visited[0][0] = true;

        while let Some((i, j)) = queue.pop_front() {
            if i + j == s3.len() {
                return true;
            }

            if i < s1.len() && s1[i] == s3[i + j] && !visited[i + 1][j] {
                visited[i + 1][j] = true;
                queue.push_back((i + 1, j));
            }

            if j < s2.len() && s2[j] == s3[i + j] && !visited[i][j + 1] {
                visited[i][j + 1] = true;
                queue.push_back((i, j + 1));
            }
        }

        false
    }
}
}