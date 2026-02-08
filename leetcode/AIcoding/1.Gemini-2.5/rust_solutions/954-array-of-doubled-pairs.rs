use std::collections::BTreeMap;

impl Solution {
    pub fn can_reorder_doubled(arr: Vec<i32>) -> bool {
        let mut counts: BTreeMap<i32, i32> = BTreeMap::new();
        for &num in arr.iter() {
            *counts.entry(num).or_insert(0) += 1;
        }

        let mut keys: Vec<i32> = counts.keys().cloned().collect();
        keys.sort_unstable_by_key(|&x| x.abs());

        for x in keys {
            let x_count = *counts.get(&x).unwrap();

            if x_count == 0 {
                continue;
            }

            if x == 0 {
                if x_count % 2 != 0 {
                    return false;
                }
                *counts.get_mut(&0).unwrap() = 0;
            } else {
                let target = 2 * x;

                if let Some(target_count) = counts.get_mut(&target) {
                    if *target_count < x_count {
                        return false;
                    }
                    *target_count -= x_count;
                    *counts.get_mut(&x).unwrap() = 0;
                } else {
                    return false;
                }
            }
        }

        true
    }
}