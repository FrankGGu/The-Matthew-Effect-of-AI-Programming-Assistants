impl Solution {
    pub fn find_first_almost_equal_substring(s: String, t: String, max_diff: i32) -> i32 {
        let s_chars: Vec<char> = s.chars().collect();
        let t_chars: Vec<char> = t.chars().collect();
        let n = s_chars.len();
        let m = t_chars.len();

        for i in 0..=n - m {
            let mut diff = 0;
            for j in 0..m {
                if s_chars[i + j] != t_chars[j] {
                    diff += 1;
                    if diff > max_diff {
                        break;
                    }
                }
            }
            if diff <= max_diff {
                return i as i32;
            }
        }
        -1
    }
}