use std::collections::HashMap;

impl Solution {
    pub fn find_original_array(changed: Vec<i32>) -> Vec<i32> {
        if changed.len() % 2 != 0 {
            return vec![];
        }

        let mut count: HashMap<i32, i32> = HashMap::new();
        for &num in &changed {
            *count.entry(num).or_insert(0) += 1;
        }

        let mut keys: Vec<i32> = count.keys().cloned().collect();
        keys.sort();

        let mut original: Vec<i32> = Vec::new();

        for &num in &keys {
            let num_count = *count.get(&num).unwrap_or(&0);
            if num_count > 0 {
                let doubled_num = num * 2;
                if !count.contains_key(&doubled_num) {
                    return vec![];
                }
                let doubled_count = *count.get(&doubled_num).unwrap_or(&0);

                if doubled_count < num_count {
                    return vec![];
                }

                original.extend(std::iter::repeat(num).take(num_count as usize));
                *count.entry(num).or_insert(0) -= num_count;
                *count.entry(doubled_num).or_insert(0) -= num_count;

            }
        }

        if original.len() == changed.len() / 2 {
            original
        } else {
            vec![]
        }
    }
}