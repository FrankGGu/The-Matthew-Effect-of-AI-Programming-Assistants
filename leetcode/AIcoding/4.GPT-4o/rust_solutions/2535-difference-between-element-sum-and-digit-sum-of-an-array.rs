impl Solution {
    pub fn difference_of_sum(nums: Vec<i32>) -> i32 {
        let element_sum: i32 = nums.iter().sum();
        let digit_sum: i32 = nums.iter().map(|&x| x.to_string().chars().map(|c| c.to_digit(10).unwrap() as i32).sum::<i32>()).sum();
        (element_sum - digit_sum).abs()
    }
}