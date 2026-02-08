impl Solution {
    pub fn difference_of_sum(nums: Vec<i32>, n: i32) -> i32 {
        let divisible_sum: i32 = nums.iter().filter(|&&x| x % n == 0).sum();
        let non_divisible_sum: i32 = nums.iter().filter(|&&x| x % n != 0).sum();
        (divisible_sum - non_divisible_sum).abs()
    }
}