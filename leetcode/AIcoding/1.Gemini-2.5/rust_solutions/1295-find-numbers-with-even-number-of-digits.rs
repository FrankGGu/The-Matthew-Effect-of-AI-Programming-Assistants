impl Solution {
    pub fn find_numbers(nums: Vec<i32>) -> i32 {
        let mut even_digit_count = 0;
        for num in nums {
            let mut digits = 0;
            let mut n = num;
            while n > 0 {
                n /= 10;
                digits += 1;
            }
            if digits % 2 == 0 {
                even_digit_count += 1;
            }
        }
        even_digit_count
    }
}