impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn at_most_n_equal_digits(mut n: i32, digits: Vec<char>) -> i32 {
        let mut digits_set = HashSet::new();
        for c in &digits {
            digits_set.insert(*c);
        }
        let mut result = 0;
        let n_str = n.to_string();
        let len = n_str.len();
        let mut digits_len = digits.len();

        for i in 1..len {
            result += digits_len.pow(i as u32);
        }

        for i in 0..len {
            let ch = n_str.chars().nth(i).unwrap();
            let mut count = 0;
            for d in &digits {
                if *d < ch {
                    count += 1;
                } else if *d == ch {
                    count += 1;
                }
            }
            result += count * digits_len.pow((len - i - 1) as u32);

            if !digits_set.contains(&ch) {
                break;
            }
        }

        result
    }
}
}