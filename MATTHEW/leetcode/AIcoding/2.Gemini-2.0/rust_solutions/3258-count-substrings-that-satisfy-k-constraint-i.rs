impl Solution {
    pub fn count_substrings(s: String, k: i32) -> i32 {
        let s_bytes = s.as_bytes();
        let n = s_bytes.len();
        let mut count = 0;

        for i in 0..n {
            for j in i..n {
                let mut distinct_chars = std::collections::HashSet::new();
                for l in i..=j {
                    distinct_chars.insert(s_bytes[l]);
                }
                if distinct_chars.len() as i32 <= k {
                    count += 1;
                }
            }
        }

        count
    }
}