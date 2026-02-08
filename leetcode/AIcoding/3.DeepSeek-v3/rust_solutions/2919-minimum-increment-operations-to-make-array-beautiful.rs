impl Solution {
    pub fn min_increment_operations(nums: Vec<i32>, k: i32) -> i64 {
        let mut dp = vec![0; 3];
        for num in nums {
            let current = (num as i64).max(k as i64) - num as i64;
            let next = current + dp.iter().min().unwrap();
            dp.rotate_left(1);
            dp[2] = next;
        }
        *dp.iter().min().unwrap()
    }
}