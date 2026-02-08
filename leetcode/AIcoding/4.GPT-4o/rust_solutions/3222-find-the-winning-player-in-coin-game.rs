impl Solution {
    pub fn find_the_winner(n: i32, k: i32) -> i32 {
        let mut winner = 0;
        for i in 2..=n {
            winner = (winner + k) % i;
        }
        winner + 1
    }
}