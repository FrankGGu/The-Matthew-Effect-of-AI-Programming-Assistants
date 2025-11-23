impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn is_power_of_two(n: i32) -> bool {
        n > 0 && (n & (n - 1)) == 0
    }

    pub fn get_digit_count(n: i32) -> HashMap<char, i32> {
        let mut count = HashMap::new();
        for c in n.to_string().chars() {
            *count.entry(c).or_insert(0) += 1;
        }
        count
    }

    pub fn reordered_power_of_two(n: i32) -> bool {
        let target = Self::get_digit_count(n);
        for i in 0..31 {
            let power = 1 << i;
            let count = Self::get_digit_count(power);
            if count == target {
                return true;
            }
        }
        false
    }
}
}