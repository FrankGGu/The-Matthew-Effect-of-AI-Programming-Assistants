impl Solution {
    pub fn minimum_moves(s: String) -> i32 {
        let mut count = 0;
        let mut i = 0;
        let chars: Vec<char> = s.chars().collect();

        while i < chars.len() {
            if chars[i] == 'X' {
                count += 1;
                i += 3;
            } else {
                i += 1;
            }
        }

        count
    }
}