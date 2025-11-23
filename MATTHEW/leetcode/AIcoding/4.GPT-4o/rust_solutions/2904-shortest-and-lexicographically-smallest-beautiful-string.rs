impl Solution {
    pub fn smallest_beautiful_string(s: String, k: i32) -> String {
        let mut s: Vec<char> = s.chars().collect();
        let n = s.len();
        let k = k as usize;

        let is_beautiful = |s: &Vec<char>| {
            for i in 1..s.len() {
                if s[i] == s[i - 1] || (i > 1 && s[i] == s[i - 2]) {
                    return false;
                }
            }
            true
        };

        for i in (0..n).rev() {
            if s[i] < (b'a' + (k as u8 - 1)) as char {
                s[i] = (s[i] as u8 + 1) as char;
                for j in (i + 1)..n {
                    s[j] = 'a';
                }
                if is_beautiful(&s) {
                    return s.iter().collect();
                }
            }
        }

        let mut result = vec!['a'; n];
        let mut i = 0;
        while i < n {
            while result[i] < (b'a' + (k as u8 - 1)) as char {
                result[i] = (result[i] as u8 + 1) as char;
                if is_beautiful(&result) {
                    return result.iter().collect();
                }
            }
            i -= 1;
        }

        "".to_string() // if no solution, return empty
    }
}