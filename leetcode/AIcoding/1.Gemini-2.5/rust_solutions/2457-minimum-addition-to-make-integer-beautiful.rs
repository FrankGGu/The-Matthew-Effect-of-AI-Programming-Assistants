impl Solution {
    fn sum_digits(mut num: i64) -> i64 {
        let mut sum = 0;
        // Handle the case where num is 0 explicitly, as the loop won't run.
        if num == 0 {
            return 0;
        }
        while num > 0 {
            sum += num % 10;
            num /= 10;
        }
        sum
    }

    pub fn make_integer_beautiful(n: i64, target: i64) -> i64 {
        let mut current_n = n;
        let mut ans = 0;
        let mut power_of_10 = 1; // Represents 1, 10, 100, ...

        loop {
            let current_sum = Solution::sum_digits(current_n);

            if current_sum <= target {
                break;
            }

            // Calculate the amount to add to make current_n a multiple of (power_of_10 * 10).
            // This effectively "clears" the digits up to the current power_of_10 place.
            // Example: if current_n = 123, power_of_10 = 1, we want to make it a multiple of 10.
            // remainder = 123 % (1 * 10) = 3. add_amount = 10 - 3 = 7. current_n becomes 130.
            // Example: if current_n = 130, power_of_10 = 10, we want to make it a multiple of 100.
            // remainder = 130 % (10 * 10) = 30. add_amount = 100 - 30 = 70. current_n becomes 200.

            let mod_base = power_of_10 * 10;
            let remainder = current_n % mod_base;

            let add_amount = if remainder == 0 {
                0
            } else {
                mod_base - remainder
            };

            ans += add_amount;
            current_n += add_amount;

            // Move to the next higher power of 10 for the next iteration
            power_of_10 *= 10;
        }

        ans
    }
}