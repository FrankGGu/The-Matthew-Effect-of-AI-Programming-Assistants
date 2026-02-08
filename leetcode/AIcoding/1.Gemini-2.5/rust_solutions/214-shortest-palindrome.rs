impl Solution {
    pub fn shortest_palindrome(s: String) -> String {
        let n = s.len();
        if n == 0 {
            return "".to_string();
        }

        let s_chars: Vec<char> = s.chars().collect();
        let s_rev_chars: Vec<char> = s.chars().rev().collect();

        let mut temp_chars = Vec::with_capacity(2 * n + 1);
        temp_chars.extend_from_slice(&s_chars);
        temp_chars.push('#');
        temp_chars.extend_from_slice(&s_rev_chars);

        let temp_len = temp_chars.len();
        let mut lps = vec![0; temp_len];

        let mut length = 0;
        let mut i = 1;

        while i < temp_len {
            if temp_chars[i] == temp_chars[length] {
                length += 1;
                lps[i] = length;
                i += 1;
            } else {
                if length != 0 {
                    length = lps[length - 1];
                } else {
                    lps[i] = 0;
                    i += 1;
                }
            }
        }

        let longest_palindromic_prefix_len = lps[temp_len - 1];

        let mut result = String::new();
        for k in 0..(n - longest_palindromic_prefix_len) {
            result.push(s_rev_chars[k]);
        }
        result.push_str(&s);

        result
    }
}