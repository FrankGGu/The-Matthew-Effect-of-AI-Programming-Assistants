impl Solution {
    pub fn shortest_beautiful_substring(s: String, k: i32) -> String {
        let s_bytes = s.as_bytes();
        let n = s.len();
        let mut min_len = n + 1;
        let mut ans = String::new();

        for i in 0..n {
            let mut ones = 0;
            for j in i..n {
                if s_bytes[j] == b'1' {
                    ones += 1;
                }
                if ones == k {
                    let len = j - i + 1;
                    let sub = String::from_utf8(s_bytes[i..=j].to_vec()).unwrap();
                    if len < min_len {
                        min_len = len;
                        ans = sub;
                    } else if len == min_len && (ans.is_empty() || sub < ans) {
                        ans = sub;
                    }
                    break;
                }
            }
        }

        if min_len == n + 1 {
            return String::new();
        }

        ans
    }
}