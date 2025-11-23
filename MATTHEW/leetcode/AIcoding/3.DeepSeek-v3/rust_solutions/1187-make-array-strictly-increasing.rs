use std::collections::HashMap;

impl Solution {
    pub fn make_array_increasing(arr1: Vec<i32>, mut arr2: Vec<i32>) -> i32 {
        arr2.sort();
        arr2.dedup();
        let mut dp: HashMap<(usize, Option<i32>), i32> = HashMap::new();
        dp.insert((0, None), 0);
        dp.insert((0, Some(arr1[0])), 0);

        for i in 1..arr1.len() {
            let mut new_dp = HashMap::new();
            for (&(pos, prev_val), &operations) in dp.iter() {
                if pos + 1 != i {
                    continue;
                }
                let current_val = arr1[i];
                if let Some(pv) = prev_val {
                    if pv < current_val {
                        let entry = new_dp.entry((i, Some(current_val))).or_insert(i32::MAX);
                        *entry = (*entry).min(operations);
                    }
                } else {
                    let entry = new_dp.entry((i, Some(current_val))).or_insert(i32::MAX);
                    *entry = (*entry).min(operations);
                }

                let idx = arr2.binary_search(&prev_val.unwrap_or(i32::MIN)).unwrap_or_else(|x| x);
                if idx < arr2.len() {
                    let new_val = arr2[idx];
                    let entry = new_dp.entry((i, Some(new_val))).or_insert(i32::MAX);
                    *entry = (*entry).min(operations + 1);
                }
            }
            dp = new_dp;
            if dp.is_empty() {
                return -1;
            }
        }

        dp.values().min().cloned().unwrap_or(-1)
    }
}