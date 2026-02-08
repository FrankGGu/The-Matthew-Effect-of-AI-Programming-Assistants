impl Solution {
    pub fn min_max_game(mut nums: Vec<i32>) -> i32 {
        while nums.len() > 1 {
            let n = nums.len();
            let mut new_nums = Vec::with_capacity(n / 2);
            for i in 0..(n / 2) {
                if i % 2 == 0 {
                    new_nums.push(nums[2 * i].min(nums[2 * i + 1]));
                } else {
                    new_nums.push(nums[2 * i].max(nums[2 * i + 1]));
                }
            }
            nums = new_nums;
        }
        nums[0]
    }
}