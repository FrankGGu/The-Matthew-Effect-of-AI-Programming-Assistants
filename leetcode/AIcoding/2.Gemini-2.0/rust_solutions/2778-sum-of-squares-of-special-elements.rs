impl Solution {
    pub fn sum_of_squares(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut sum = 0;
        for i in 0..n {
            if (i + 1) % (n as i32).sqrt() as usize == 0 {
                sum += nums[i] * nums[i];
            }
        }
        sum
    }
}