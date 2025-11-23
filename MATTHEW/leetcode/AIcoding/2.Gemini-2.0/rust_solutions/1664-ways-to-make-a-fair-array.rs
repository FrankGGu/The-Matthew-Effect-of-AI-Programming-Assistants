impl Solution {
    pub fn ways_to_make_fair(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut even_sum = 0;
        let mut odd_sum = 0;
        for i in 0..n {
            if i % 2 == 0 {
                even_sum += nums[i];
            } else {
                odd_sum += nums[i];
            }
        }

        let mut count = 0;
        let mut current_even = 0;
        let mut current_odd = 0;

        for i in 0..n {
            if i % 2 == 0 {
                even_sum -= nums[i];
                if current_even + odd_sum == current_odd + even_sum {
                    count += 1;
                }
                current_even += nums[i];
            } else {
                odd_sum -= nums[i];
                if current_even + odd_sum == current_odd + even_sum {
                    count += 1;
                }
                current_odd += nums[i];
            }
        }

        count
    }
}