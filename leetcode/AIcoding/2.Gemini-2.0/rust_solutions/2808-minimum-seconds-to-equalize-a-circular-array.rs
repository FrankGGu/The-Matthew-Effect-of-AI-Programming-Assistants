use std::collections::HashMap;

impl Solution {
    pub fn minimum_seconds(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut positions: HashMap<i32, Vec<usize>> = HashMap::new();

        for (i, &num) in nums.iter().enumerate() {
            positions.entry(num).or_insert(Vec::new()).push(i);
        }

        let mut min_seconds = i32::MAX;

        for &num in positions.keys() {
            let pos = positions.get(&num).unwrap();
            let mut max_diff = 0;
            for i in 0..pos.len() {
                let diff;
                if i == pos.len() - 1 {
                    diff = pos[0] + n - pos[i];
                } else {
                    diff = pos[i + 1] - pos[i];
                }
                max_diff = max_diff.max(diff);
            }
            min_seconds = min_seconds.min(max_diff as i32 / 2);
        }

        min_seconds
    }
}