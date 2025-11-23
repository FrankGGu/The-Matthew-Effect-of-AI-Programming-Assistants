impl Solution {
    pub fn sum_of_squares(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        nums.iter()
            .enumerate()
            .filter(|&(i, &num)| (i + 1) % (n as i32) == 0 || (i + 1) % num == 0)
            .map(|(_, &num)| num * num)
            .sum()
    }
}