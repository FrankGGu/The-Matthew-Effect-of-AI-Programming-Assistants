use std::collections::HashMap;

impl Solution {
    pub fn min_set_size(arr: Vec<i32>) -> i32 {
        let n = arr.len();
        let target_removed = n / 2;

        let mut freq_map: HashMap<i32, i32> = HashMap::new();
        for &num in arr.iter() {
            *freq_map.entry(num).or_insert(0) += 1;
        }

        let mut frequencies: Vec<i32> = freq_map.values().cloned().collect();
        frequencies.sort_unstable_by(|a, b| b.cmp(a));

        let mut removed_count = 0;
        let mut set_count = 0;

        for freq in frequencies.into_iter() {
            removed_count += freq as usize;
            set_count += 1;
            if removed_count >= target_removed {
                break;
            }
        }

        set_count
    }
}