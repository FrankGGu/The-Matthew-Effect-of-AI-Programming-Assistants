impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn wonderful_substrings(mut word: String) -> i64 {
        let mut count = HashMap::new();
        count.insert(0, 1);
        let mut result = 0;
        let mut mask = 0;

        for c in word.chars() {
            let idx = c as usize - 'a' as usize;
            mask ^= 1 << idx;

            for i in 0..26 {
                let temp_mask = mask ^ (1 << i);
                if let Some(&v) = count.get(&temp_mask) {
                    result += v;
                }
            }

            *count.entry(mask).or_insert(0) += 1;
        }

        result
    }
}
}