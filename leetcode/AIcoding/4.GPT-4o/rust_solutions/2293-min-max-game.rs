impl Solution {
    pub fn min_max_game(nums: Vec<i32>) -> i32 {
        let mut nums = nums;
        while nums.len() > 1 {
            let mut new_nums = Vec::new();
            for i in (0..nums.len()).step_by(2) {
                if i % 4 == 0 {
                    new_nums.push(nums[i].min(nums[i + 1]));
                } else {
                    new_nums.push(nums[i].max(nums[i + 1]));
                }
            }
            nums = new_nums;
        }
        nums[0]
    }
}