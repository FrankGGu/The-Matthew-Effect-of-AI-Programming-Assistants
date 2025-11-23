impl Solution {
    pub fn max_alternating_sum(nums: Vec<i32>) -> i64 {
        let n = nums.len();
        let mut even = 0;
        let mut odd = 0;
        for i in 0..n {
            let new_even = std::cmp::max(even, odd + nums[i] as i64);
            let new_odd = std::cmp::max(odd, even - nums[i] as i64);
            even = new_even;
            odd = new_odd;
        }
        even
    }
}