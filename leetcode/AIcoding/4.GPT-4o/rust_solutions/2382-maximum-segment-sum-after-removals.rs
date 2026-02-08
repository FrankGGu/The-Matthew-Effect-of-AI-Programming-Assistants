impl Solution {
    pub fn maximum_segment_sum(nums: Vec<i32>, remove: Vec<i32>) -> i64 {
        use std::collections::HashSet;
        let n = nums.len();
        let mut removed = HashSet::new();
        for &r in &remove {
            removed.insert(r as usize);
        }

        let mut max_sum = 0;
        let mut current_sum = 0;

        for i in 0..n {
            if removed.contains(&i) {
                max_sum = max_sum.max(current_sum);
                current_sum = 0;
            } else {
                current_sum += nums[i] as i64;
            }
        }
        max_sum.max(current_sum)
    }
}