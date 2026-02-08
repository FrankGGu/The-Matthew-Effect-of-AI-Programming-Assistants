impl Solution {
    pub fn count_substrings(s: String, c: char) -> i32 {
        let mut count = 0;
        let chars: Vec<char> = s.chars().collect();
        for i in 0..chars.len() {
            if chars[i] == c {
                for j in i..chars.len() {
                    if chars[j] == c {
                        count += 1;
                    }
                }
            }
        }
        count
    }
}