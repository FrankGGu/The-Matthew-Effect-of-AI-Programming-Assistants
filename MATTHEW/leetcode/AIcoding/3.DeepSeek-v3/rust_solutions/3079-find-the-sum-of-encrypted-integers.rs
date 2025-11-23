impl Solution {
    pub fn sum_of_encrypted_int(nums: Vec<i32>) -> i32 {
        nums.iter().map(|&num| {
            let mut max_digit = 0;
            let mut count = 0;
            let mut n = num;
            while n > 0 {
                let digit = n % 10;
                if digit > max_digit {
                    max_digit = digit;
                }
                n /= 10;
                count += 1;
            }
            if count == 0 {
                count = 1;
            }
            let mut encrypted = 0;
            for _ in 0..count {
                encrypted = encrypted * 10 + max_digit;
            }
            encrypted
        }).sum()
    }
}