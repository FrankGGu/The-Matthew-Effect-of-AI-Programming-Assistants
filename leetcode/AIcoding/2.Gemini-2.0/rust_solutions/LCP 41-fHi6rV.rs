impl Solution {
    pub fn flip_game(board: Vec<String>) -> Vec<String> {
        let mut res = vec![];
        let n = board.len();
        for i in 0..n {
            let s = board[i].as_bytes();
            for j in 0..s.len() - 1 {
                if s[j] == '+' as u8 && s[j + 1] == '+' as u8 {
                    let mut new_s = s.to_vec();
                    new_s[j] = '-' as u8;
                    new_s[j + 1] = '-' as u8;
                    res.push(String::from_utf8(new_s).unwrap());
                }
            }
        }
        res
    }
}