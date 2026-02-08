impl Solution {
    pub fn ways_to_split_array(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut total_sum: i64 = 0;
        for &num in &nums {
            total_sum += num as i64;
        }

        let mut count = 0;
        let mut left_sum: i64 = 0;

        for i in 0..n - 1 {
            left_sum += nums[i] as i64;
            let right_sum = total_sum - left_sum;
            if left_sum >= right_sum {
                count += 1;
            }
        }

        count
    }
}