impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn beautiful_subsets(nums: Vec<i32>, k: i32) -> i32 {
        let mut count = HashMap::new();
        for &num in &nums {
            *count.entry(num).or_insert(0) += 1;
        }

        let mut result = 0;
        let mut keys: Vec<i32> = count.keys().cloned().collect();
        keys.sort();

        Self::dfs(&keys, 0, &count, k, &mut result);
        result
    }

    fn dfs(keys: &[i32], index: usize, count: &HashMap<i32, i32>, k: i32, result: &mut i32) {
        if index == keys.len() {
            *result += 1;
            return;
        }

        let num = keys[index];
        let prev = num - k;
        let take = if count.contains_key(&prev) {
            count[&prev]
        } else {
            0
        };

        // Not take current number
        Self::dfs(keys, index + 1, count, k, result);

        // Take current number
        if take == 0 {
            *count.get_mut(&num).unwrap() -= 1;
            Self::dfs(keys, index + 1, count, k, result);
            *count.get_mut(&num).unwrap() += 1;
        }
    }
}
}