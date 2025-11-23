impl Solution {
    pub fn min_operations(nums: Vec<i32>, k: i32) -> i32 {
        let mut count = 0;
        let mut seen = std::collections::HashSet::new();
        for i in (0..nums.len()).rev() {
            count += 1;
            if nums[i] <= k {
                seen.insert(nums[i]);
            }
            if seen.len() as i32 == k {
                return count;
            }
        }
        0
    }
}