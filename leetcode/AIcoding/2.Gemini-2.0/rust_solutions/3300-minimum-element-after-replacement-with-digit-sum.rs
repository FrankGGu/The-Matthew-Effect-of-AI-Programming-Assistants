impl Solution {
    pub fn minimize_sum(nums: Vec<i32>) -> i32 {
        let mut nums = nums;
        for i in 0..nums.len() {
            while nums[i] >= 10 {
                let mut sum = 0;
                let mut temp = nums[i];
                while temp > 0 {
                    sum += temp % 10;
                    temp /= 10;
                }
                nums[i] = sum;
            }
        }
        nums.into_iter().sum()
    }
}