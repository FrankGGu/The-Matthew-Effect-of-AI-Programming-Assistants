impl Solution {
    pub fn min_moves(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let sum: i32 = nums.iter().sum();
        let target = (n as i32 * (n as i32 + 1)) / 2;
        let diff = target - sum;
        (diff + n - 1) / n
    }
}