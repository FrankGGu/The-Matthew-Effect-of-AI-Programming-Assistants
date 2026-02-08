impl Solution {
    pub fn find_lus_length(strs: Vec<String>) -> i32 {
        let mut max_len = -1;
        let n = strs.len();

        for i in 0..n {
            let mut is_subsequence = false;
            for j in 0..n {
                if i == j {
                    continue;
                }
                if Self::is_subsequence(&strs[i], &strs[j]) {
                    is_subsequence = true;
                    break;
                }
            }
            if !is_subsequence {
                max_len = max_len.max(strs[i].len() as i32);
            }
        }

        max_len
    }

    fn is_subsequence(a: &str, b: &str) -> bool {
        let a_chars: Vec<char> = a.chars().collect();
        let b_chars: Vec<char> = b.chars().collect();
        let mut i = 0;
        let mut j = 0;

        while i < a_chars.len() && j < b_chars.len() {
            if a_chars[i] == b_chars[j] {
                i += 1;
            }
            j += 1;
        }

        i == a_chars.len()
    }
}