impl Solution {
    pub fn minimum_moves(s: String) -> i32 {
        let n = s.len();
        let s_bytes = s.as_bytes();
        let mut moves = 0;
        let mut i = 0;

        while i < n {
            if s_bytes[i] == b'X' {
                moves += 1;
                i += 3;
            } else {
                i += 1;
            }
        }
        moves
    }
}