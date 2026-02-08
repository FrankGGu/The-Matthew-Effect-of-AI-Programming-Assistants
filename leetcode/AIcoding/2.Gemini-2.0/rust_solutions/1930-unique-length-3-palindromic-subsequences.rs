impl Solution {
    pub fn count_palindromic_subsequence(s: String) -> i32 {
        let s_bytes = s.as_bytes();
        let n = s.len();
        let mut count = 0;
        for a in b'a'..=b'z' {
            let mut first = n;
            let mut last = -1;
            for i in 0..n {
                if s_bytes[i] == a {
                    first = i;
                    break;
                }
            }
            for i in (0..n).rev() {
                if s_bytes[i] == a {
                    last = i as i32;
                    break;
                }
            }
            if first < last as usize {
                let mut distinct = std::collections::HashSet::new();
                for i in first + 1..last as usize {
                    distinct.insert(s_bytes[i]);
                }
                count += distinct.len() as i32;
            }
        }
        count
    }
}