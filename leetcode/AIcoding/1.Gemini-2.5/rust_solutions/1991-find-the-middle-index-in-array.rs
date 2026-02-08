impl Solution {
    pub fn find_middle_index(nums: Vec<i32>) -> i32 {
        let total_sum: i32 = nums.iter().sum();
        let mut left_sum: i32 = 0;

        for (i, &num) in nums.iter().enumerate() {
            let right_sum = total_sum - left_sum - num;
            if left_sum == right_sum {
                return i as i32;
            }
            left_sum += num;
        }

        -1
    }
}