struct Solution;

impl Solution {
    pub fn min_cost(to_remove: i32, s: String) -> i32 {
        let mut cost = 0;
        let mut count = 0;
        for c in s.chars() {
            if c == 'a' {
                count += 1;
            } else {
                count = 0;
            }
            if count >= to_remove {
                cost += 1;
                count = 0;
            }
        }
        cost
    }
}