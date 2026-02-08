impl Solution {
    pub fn game(guess: Vec<i32>, answer: Vec<i32>) -> i32 {
        let mut count = 0;
        for i in 0..3 {
            if guess[i] == answer[i] {
                count += 1;
            }
        }
        count
    }
}