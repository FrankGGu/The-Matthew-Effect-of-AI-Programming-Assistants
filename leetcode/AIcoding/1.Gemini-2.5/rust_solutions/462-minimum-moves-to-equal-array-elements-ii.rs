impl Solution {
    pub fn min_moves2(mut nums: Vec<i32>) -> i32 {
        nums.sort();
        let n = nums.len();
        let median = nums[n / 2];
        let mut moves = 0;
        for &num in nums.iter() {
            moves += (num - median).abs();
        }
        moves
    }
}