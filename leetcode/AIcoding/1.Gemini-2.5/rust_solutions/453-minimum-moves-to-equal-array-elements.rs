impl Solution {
    pub fn min_moves(nums: Vec<i32>) -> i32 {
        let min_val = *nums.iter().min().unwrap();
        let sum_nums: i64 = nums.iter().map(|&x| x as i64).sum();
        let n = nums.len() as i64;

        let moves = sum_nums - n * (min_val as i64);

        moves as i32
    }
}