impl Solution {
    pub fn difference_of_sum(nums: Vec<i32>) -> i32 {
        let element_sum: i32 = nums.iter().sum();
        let digit_sum: i32 = nums.iter().map(|&num| {
            let mut n = num;
            let mut sum = 0;
            while n > 0 {
                sum += n % 10;
                n /= 10;
            }
            sum
        }).sum();
        (element_sum - digit_sum).abs()
    }
}