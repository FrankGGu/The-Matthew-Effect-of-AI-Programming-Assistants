use std::collections::HashSet;

impl Solution {
    pub fn is_happy(n: i32) -> bool {
        let mut seen = HashSet::new();
        let mut num = n;
        while num != 1 {
            if seen.contains(&num) {
                return false;
            }
            seen.insert(num);
            num = num.to_string().chars().map(|c| {
                let d = c.to_digit(10).unwrap();
                d * d
            }).sum::<u32>() as i32;
        }
        true
    }
}