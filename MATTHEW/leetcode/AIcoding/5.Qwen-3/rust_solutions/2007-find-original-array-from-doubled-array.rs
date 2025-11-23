impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn find_original_array(mut changed: Vec<i32>) -> Vec<i32> {
        if changed.len() % 2 != 0 {
            return vec![];
        }

        let mut freq = HashMap::new();
        for &num in &changed {
            *freq.entry(num).or_insert(0) += 1;
        }

        changed.sort();

        let mut original = Vec::with_capacity(changed.len() / 2);

        for &num in &changed {
            if let Some(&count) = freq.get(&num) {
                if count == 0 {
                    continue;
                }

                original.push(num);

                let double = num * 2;
                if let Some(&mut cnt) = freq.get_mut(&double) {
                    *cnt -= 1;
                }
            }
        }

        if original.len() == changed.len() / 2 {
            original
        } else {
            vec![]
        }
    }
}
}