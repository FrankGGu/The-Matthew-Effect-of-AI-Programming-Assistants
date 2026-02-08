use std::collections::HashMap;

impl Solution {
    pub fn minimum_seconds(nums: Vec<i32>) -> i32 {
        let mut pos = HashMap::new();
        for (i, &num) in nums.iter().enumerate() {
            pos.entry(num).or_insert(Vec::new()).push(i);
        }

        let n = nums.len() as i32;
        let mut min_time = i32::MAX;

        for (_, indices) in pos {
            let mut max_gap = 0;
            let m = indices.len();
            for i in 0..m {
                let gap = (indices[(i + 1) % m] as i32 - indices[i] as i32 - 1 + n) % n;
                max_gap = max_gap.max(gap);
            }
            let time = (max_gap + 1) / 2;
            min_time = min_time.min(time);
        }

        min_time
    }
}