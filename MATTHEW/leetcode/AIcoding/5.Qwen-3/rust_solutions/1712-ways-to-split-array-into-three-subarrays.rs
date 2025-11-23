struct Solution;

impl Solution {
    pub fn ways_to_split_array(nums: Vec<i32>) -> i32 {
        let mut total = 0;
        for &num in &nums {
            total += num;
        }

        let mut left_sum = 0;
        let mut count = 0;

        for i in 0..nums.len() - 1 {
            left_sum += nums[i];
            let right_sum = total - left_sum;
            if left_sum > right_sum {
                break;
            }
            count += 1;
        }

        count as i32
    }
}