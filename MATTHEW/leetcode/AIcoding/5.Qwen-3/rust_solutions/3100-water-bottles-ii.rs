struct Solution;

impl Solution {
    pub fn num_water_bottles(mut total: i32, mut empty: i32) -> i32 {
        let mut drunk = 0;
        while total > 0 {
            drunk += total;
            let new = total / empty;
            total = new;
            total += total % empty;
        }
        drunk
    }
}