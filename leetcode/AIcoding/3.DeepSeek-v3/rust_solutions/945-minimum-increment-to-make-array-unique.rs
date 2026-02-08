impl Solution {
    pub fn min_increment_for_unique(mut nums: Vec<i32>) -> i32 {
        nums.sort_unstable();
        let mut moves = 0;
        for i in 1..nums.len() {
            if nums[i] <= nums[i - 1] {
                let required = nums[i - 1] + 1;
                moves += required - nums[i];
                nums[i] = required;
            }
        }
        moves
    }
}