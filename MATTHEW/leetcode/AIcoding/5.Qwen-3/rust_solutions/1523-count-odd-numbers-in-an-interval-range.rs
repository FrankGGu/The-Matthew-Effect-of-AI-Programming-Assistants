struct Solution;

impl Solution {
    pub fn count_odds(low: i32, high: i32) -> i32 {
        let mut count = 0;
        for i in low..=high {
            if i % 2 != 0 {
                count += 1;
            }
        }
        count
    }
}