impl Solution {
    pub fn triangular_sum(nums: Vec<i32>) -> i32 {
        let mut nums = nums;
        while nums.len() > 1 {
            let mut new_nums = Vec::with_capacity(nums.len() - 1);
            for i in 0..nums.len() - 1 {
                new_nums.push((nums[i] + nums[i + 1]) % 10);
            }
            nums = new_nums;
        }
        nums[0]
    }
}