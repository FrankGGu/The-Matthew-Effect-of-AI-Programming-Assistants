impl Solution {

use std::collections::HashMap;

struct Solution;

impl Solution {
    pub fn num_tile_possibilities(s: String) -> i32 {
        let mut count = HashMap::new();
        for c in s.chars() {
            *count.entry(c).or_insert(0) += 1;
        }
        Self::backtrack(&count)
    }

    fn backtrack(count: &HashMap<char, i32>) -> i32 {
        let mut total = 0;
        for (&c, &mut freq) in count.iter_mut() {
            if freq > 0 {
                total += 1;
                *freq -= 1;
                total += Self::backtrack(count);
                *freq += 1;
            }
        }
        total
    }
}
}