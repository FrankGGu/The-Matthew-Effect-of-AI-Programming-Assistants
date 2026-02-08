impl Solution {
    pub fn min_moves(nums: Vec<i32>) -> i32 {
        let mut min_val = nums[0];
        for &num in &nums {
            min_val = min_val.min(num);
        }
        let mut moves = 0;
        for &num in &nums {
            moves += num - min_val;
        }
        moves
    }
}