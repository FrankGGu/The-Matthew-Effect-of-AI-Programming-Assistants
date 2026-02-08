impl Solution {
    pub fn ways_to_split_array(nums: Vec<i32>) -> i32 {
        let total_sum: i32 = nums.iter().sum();
        let mut left_sum = 0;
        let mut count = 0;

        for i in 0..nums.len() - 1 {
            left_sum += nums[i];
            if left_sum >= total_sum - left_sum {
                count += 1;
            }
        }

        count
    }
}