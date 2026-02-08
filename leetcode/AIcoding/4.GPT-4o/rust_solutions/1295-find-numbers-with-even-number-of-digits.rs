impl Solution {
    pub fn find_numbers(nums: Vec<i32>) -> i32 {
        nums.iter().filter(|&&x| (x as f64).log(10.0).floor() as i32 % 2 == 1).count() as i32
    }
}