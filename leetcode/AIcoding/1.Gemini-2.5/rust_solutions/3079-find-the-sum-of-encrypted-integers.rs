impl Solution {
    pub fn sum_of_encrypted_int(nums: Vec<i32>) -> i32 {
        let mut total_sum = 0;

        for num in nums {
            if num == 0 {
                continue;
            }

            let mut temp_num = num;
            let mut max_digit = 0;
            let mut num_digits = 0;

            // Find the maximum digit and count the number of digits
            while temp_num > 0 {
                let digit = temp_num % 10;
                if digit > max_digit {
                    max_digit = digit;
                }
                num_digits += 1;
                temp_num /= 10;
            }

            // Construct the encrypted number
            let mut encrypted_num = 0;
            for _ in 0..num_digits {
                encrypted_num = encrypted_num * 10 + max_digit;
            }

            total_sum += encrypted_num;
        }

        total_sum
    }
}