impl Solution {
    pub fn maximum_or(nums: Vec<i32>, k: i32) -> i64 {
        let mut max_or: i64 = 0;
        let n = nums.len();
        for i in 0..n {
            let mut current_or: i64 = 0;
            for j in 0..n {
                if i == j {
                    current_or |= (nums[j] as i64) << k;
                } else {
                    current_or |= nums[j] as i64;
                }
            }
            max_or = max_or.max(current_or);
        }
        max_or
    }
}