impl Solution {
    pub fn partition_disjoint(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut left_max = nums[0];
        let mut max = nums[0];
        let mut partition_idx = 0;

        for i in 1..n {
            max = max.max(nums[i]);
            if nums[i] < left_max {
                left_max = max;
                partition_idx = i;
            }
        }

        (partition_idx + 1) as i32
    }
}