impl Solution {
    pub fn min_increments(nums: Vec<i32>, target: i32) -> i64 {
        let mut total_increments: i64 = 0;
        for num in nums {
            let remainder = num % target;
            if remainder != 0 {
                total_increments += (target - remainder) as i64;
            }
        }
        total_increments
    }
}