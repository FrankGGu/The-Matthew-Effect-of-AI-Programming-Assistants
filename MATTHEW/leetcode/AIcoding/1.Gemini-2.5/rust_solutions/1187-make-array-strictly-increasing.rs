use std::collections::HashMap;

impl Solution {
    pub fn make_array_strictly_increasing(mut arr1: Vec<i32>, mut arr2: Vec<i32>) -> i32 {
        arr2.sort_unstable();
        arr2.dedup();

        let mut dp: HashMap<i32, i32> = HashMap::new();
        dp.insert(-1, 0);

        for &num in arr1.iter() {
            let mut next_dp: HashMap<i32, i32> = HashMap::new();

            for (&prev_val, &ops) in dp.iter() {
                if num > prev_val {
                    next_dp.entry(num)
                        .and_modify(|current_ops| *current_ops = (*current_ops).min(ops))
                        .or_insert(ops);
                }

                let idx = arr2.partition_point(|&x| x <= prev_val);

                if idx < arr2.len() {
                    let replacement_val = arr2[idx];
                    next_dp.entry(replacement_val)
                        .and_modify(|current_ops| *current_ops = (*current_ops).min(ops + 1))
                        .or_insert(ops + 1);
                }
            }
            dp = next_dp;

            if dp.is_empty() {
                return -1;
            }
        }

        dp.values().min().map_or(-1, |&min_ops| min_ops)
    }
}