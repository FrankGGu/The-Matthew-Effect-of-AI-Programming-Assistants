struct Solution;

impl Solution {
    pub fn is_winner(score1: Vec<i32>, score2: Vec<i32>) -> bool {
        let sum1 = score1.iter().sum::<i32>();
        let sum2 = score2.iter().sum::<i32>();
        sum1 > sum2
    }
}