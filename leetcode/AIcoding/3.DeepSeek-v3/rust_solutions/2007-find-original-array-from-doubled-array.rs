use std::collections::HashMap;

impl Solution {
    pub fn find_original_array(changed: Vec<i32>) -> Vec<i32> {
        if changed.len() % 2 != 0 {
            return vec![];
        }

        let mut count_map = HashMap::new();
        let mut original = Vec::new();
        let mut changed = changed;
        changed.sort_unstable();

        for &num in &changed {
            *count_map.entry(num).or_insert(0) += 1;
        }

        for &num in &changed {
            if *count_map.get(&num).unwrap() == 0 {
                continue;
            }

            let doubled = num * 2;
            if let Some(cnt) = count_map.get_mut(&doubled) {
                if *cnt == 0 {
                    return vec![];
                }
                *cnt -= 1;
                *count_map.get_mut(&num).unwrap() -= 1;
                original.push(num);
            } else {
                return vec![];
            }
        }

        original
    }
}