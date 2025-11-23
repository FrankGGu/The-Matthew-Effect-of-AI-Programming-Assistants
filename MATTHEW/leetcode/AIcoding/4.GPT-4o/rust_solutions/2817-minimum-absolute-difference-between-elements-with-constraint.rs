use std::collections::BTreeSet;

impl Solution {
    pub fn minimum_absolute_difference(arr: Vec<i32>, d: i32) -> i32 {
        let mut set = BTreeSet::new();
        let mut result = i32::MAX;

        for i in 0..arr.len() {
            if i as i32 >= d {
                set.remove(&(arr[i - d as usize]));
            }
            if let Some(&&smaller) = set.range(..arr[i]).next_back() {
                result = result.min((arr[i] - smaller).abs());
            }
            if let Some(&&larger) = set.range(arr[i]..).next() {
                result = result.min((larger - arr[i]).abs());
            }
            set.insert(arr[i]);
        }

        result
    }
}