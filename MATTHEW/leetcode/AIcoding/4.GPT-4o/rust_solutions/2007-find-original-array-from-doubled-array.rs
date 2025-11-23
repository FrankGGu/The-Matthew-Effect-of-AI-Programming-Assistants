use std::collections::HashMap;

impl Solution {
    pub fn find_original_array(changed: Vec<i32>) -> Vec<i32> {
        if changed.len() % 2 != 0 {
            return Vec::new();
        }

        let mut count = HashMap::new();
        for &num in &changed {
            *count.entry(num).or_insert(0) += 1;
        }

        let mut original = Vec::new();
        let mut keys: Vec<i32> = count.keys().cloned().collect();
        keys.sort();

        for num in keys {
            if let Some(&c) = count.get(&num) {
                if c > 0 {
                    let double_num = num * 2;
                    if let Some(&dc) = count.get(&double_num) {
                        if dc < c {
                            return Vec::new();
                        }
                        original.extend(vec![num; c as usize]);
                        *count.get_mut(&double_num).unwrap() -= c;
                    }
                }
            }
        }

        original
    }
}