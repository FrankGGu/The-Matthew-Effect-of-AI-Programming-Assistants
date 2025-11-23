use std::collections::HashMap;

impl Solution {
    pub fn roman_to_int(s: String) -> i32 {
        let map: HashMap<char, i32> = [
            ('I', 1),
            ('V', 5),
            ('X', 10),
            ('L', 50),
            ('C', 100),
            ('D', 500),
            ('M', 1000),
        ].iter().cloned().collect();

        let mut prev = 0;
        let mut total = 0;

        for c in s.chars().rev() {
            let num = map[&c];
            if num < prev {
                total -= num;
            } else {
                total += num;
            }
            prev = num;
        }

        total
    }
}