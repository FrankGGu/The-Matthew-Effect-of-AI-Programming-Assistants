impl Solution {
    pub fn max_score(board: Vec<i32>, rolls: Vec<i32>) -> i32 {
        let n = board.len();
        let mut score = 0;
        let mut pos = 0;

        for &roll in &rolls {
            let mut count = roll as usize;
            while count > 0 {
                pos = (pos + 1) % n;
                score += board[pos];
                count -= 1;
            }
        }

        score
    }
}