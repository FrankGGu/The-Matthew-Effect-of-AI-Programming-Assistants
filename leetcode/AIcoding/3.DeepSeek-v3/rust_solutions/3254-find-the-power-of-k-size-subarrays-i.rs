impl Solution {
    pub fn sum_of_power(nums: Vec<i32>, k: i32) -> i32 {
        let mut count = 0;
        let n = nums.len();
        for i in 0..n {
            let mut sum = 0;
            for j in i..n {
                sum += nums[j];
                if sum == k {
                    count += 1;
                }
            }
        }
        count
    }
}