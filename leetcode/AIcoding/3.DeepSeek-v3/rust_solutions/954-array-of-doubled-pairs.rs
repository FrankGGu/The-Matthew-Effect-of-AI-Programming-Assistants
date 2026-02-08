use std::collections::HashMap;

impl Solution {
    pub fn can_reorder_doubled(arr: Vec<i32>) -> bool {
        let mut count = HashMap::new();
        let mut arr = arr;
        arr.sort_unstable_by_key(|&x| x.abs());

        for &num in &arr {
            *count.entry(num).or_insert(0) += 1;
        }

        for &num in &arr {
            if *count.get(&num).unwrap() == 0 {
                continue;
            }
            let doubled = num * 2;
            if let Some(cnt) = count.get_mut(&doubled) {
                if *cnt > 0 {
                    *count.get_mut(&num).unwrap() -= 1;
                    *cnt -= 1;
                } else {
                    return false;
                }
            } else {
                return false;
            }
        }

        true
    }
}