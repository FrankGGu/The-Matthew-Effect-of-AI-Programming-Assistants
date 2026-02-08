impl Solution {
    pub fn beautiful_indices(nums: Vec<i32>) -> Vec<i32> {
        let mut result = Vec::new();
        let n = nums.len();
        for i in 0..n {
            let mut left_sum = 0;
            let mut right_sum = 0;
            for j in 0..i {
                left_sum += nums[j];
            }
            for j in (i + 1)..n {
                right_sum += nums[j];
            }
            if left_sum == right_sum {
                result.push(i as i32);
            }
        }
        result
    }
}