impl Solution {

use std::collections::HashMap;

struct Solution;

impl Solution {
    pub fn original_digits(s: String) -> String {
        let mut count = vec![0; 10];
        let mut freq = HashMap::new();

        for c in s.chars() {
            *freq.entry(c).or_insert(0) += 1;
        }

        // zero
        count[0] = *freq.get(&'z').unwrap_or(&0);
        // two
        count[2] = *freq.get(&'w').unwrap_or(&0);
        // four
        count[4] = *freq.get(&'u').unwrap_or(&0);
        // six
        count[6] = *freq.get(&'x').unwrap_or(&0);
        // eight
        count[8] = *freq.get(&'g').unwrap_or(&0);
        // one
        count[1] = *freq.get(&'o').unwrap_or(&0) - count[0] - count[2] - count[4];
        // three
        count[3] = *freq.get(&'h').unwrap_or(&0) - count[8];
        // five
        count[5] = *freq.get(&'f').unwrap_or(&0) - count[4];
        // seven
        count[7] = *freq.get(&'s').unwrap_or(&0) - count[6];
        // nine
        count[9] = *freq.get(&'i').unwrap_or(&0) - count[5] - count[6] - count[8];

        let mut result = String::new();
        for i in 0..10 {
            for _ in 0..count[i] {
                result.push((b'0' + i as u8) as char);
            }
        }

        result
    }
}
}