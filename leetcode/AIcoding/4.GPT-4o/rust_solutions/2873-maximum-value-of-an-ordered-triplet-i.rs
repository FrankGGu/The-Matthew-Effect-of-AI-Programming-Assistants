impl Solution {
    pub fn maximum_triplet_value(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut max_value = 0;

        for i in 0..n {
            for j in (i + 1)..n {
                for k in (j + 1)..n {
                    let value = (nums[i] - nums[j]).abs() + (nums[j] - nums[k]).abs() + (nums[k] - nums[i]).abs();
                    max_value = max_value.max(value);
                }
            }
        }

        max_value
    }
}