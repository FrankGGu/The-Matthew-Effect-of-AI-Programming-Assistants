impl Solution {
    pub fn minimum_moves(s: String) -> i32 {
        let mut moves = 0;
        let mut chars: Vec<char> = s.chars().collect();
        let n = chars.len();
        let mut i = 0;

        while i < n {
            if chars[i] == 'X' {
                moves += 1;
                i += 3;
            } else {
                i += 1;
            }
        }

        moves
    }
}