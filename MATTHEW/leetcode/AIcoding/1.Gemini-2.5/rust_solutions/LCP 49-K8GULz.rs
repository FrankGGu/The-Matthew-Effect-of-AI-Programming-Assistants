impl Solution {
    pub fn find_the_winner(n: i32, k: i32) -> i32 {
        let mut winner_idx = 0;
        for i in 1..=n {
            winner_idx = (winner_idx + k) % i;
        }
        winner_idx + 1
    }
}