impl Solution {
    pub fn min_increment_for_unique(mut nums: Vec<i32>) -> i32 {
        if nums.is_empty() {
            return 0;
        }

        nums.sort_unstable();

        let mut moves = 0;
        let mut current_expected_unique = nums[0];

        for i in 1..nums.len() {
            if nums[i] <= current_expected_unique {
                moves += (current_expected_unique + 1) - nums[i];
                current_expected_unique += 1;
            } else {
                current_expected_unique = nums[i];
            }
        }

        moves
    }
}