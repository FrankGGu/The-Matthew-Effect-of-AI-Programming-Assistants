struct Solution;

impl Solution {
    pub fn min_operations(mut nums: Vec<i32>, mut k: i32) -> i32 {
        let mut operations = 0;
        while k > 0 {
            for i in 0..nums.len() {
                if nums[i] >= k {
                    nums[i] -= k;
                    operations += 1;
                }
            }
            k -= 1;
        }
        operations
    }
}