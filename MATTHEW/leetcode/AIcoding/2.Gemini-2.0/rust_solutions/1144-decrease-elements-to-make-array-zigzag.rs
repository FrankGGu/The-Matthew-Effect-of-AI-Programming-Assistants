impl Solution {
    pub fn moves_to_make_zigzag(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut even_moves = 0;
        let mut odd_moves = 0;

        let mut even_nums = nums.clone();
        let mut odd_nums = nums.clone();

        for i in (0..n).step_by(2) {
            let mut left = i32::MAX;
            if i > 0 {
                left = even_nums[i - 1];
            }
            let mut right = i32::MAX;
            if i < n - 1 {
                right = even_nums[i + 1];
            }

            if even_nums[i] >= std::cmp::min(left, right) {
                even_moves += even_nums[i] - std::cmp::min(left, right) + 1;
                even_nums[i] = std::cmp::min(left, right) - 1;
            }
        }

        for i in (1..n).step_by(2) {
            let mut left = i32::MAX;
            if i > 0 {
                left = odd_nums[i - 1];
            }
            let mut right = i32::MAX;
            if i < n - 1 {
                right = odd_nums[i + 1];
            }

            if odd_nums[i] >= std::cmp::min(left, right) {
                odd_moves += odd_nums[i] - std::cmp::min(left, right) + 1;
                odd_nums[i] = std::cmp::min(left, right) - 1;
            }
        }

        std::cmp::min(even_moves, odd_moves)
    }
}