impl Solution {
    pub fn check_perfect_number(num: i32) -> bool {
        if num <= 1 {
            return false;
        }

        let mut sum_divisors = 1; // 1 is always a proper divisor for any num > 1
        let limit = (num as f64).sqrt() as i32;

        for i in 2..=limit {
            if num % i == 0 {
                sum_divisors += i;
                // If i * i == num, then i is the square root and num / i is also i.
                // We only add it once.
                if i * i != num {
                    sum_divisors += num / i;
                }
            }
            // Optimization: If sum_divisors already exceeds num, it cannot be a perfect number.
            // This is not strictly necessary for correctness but can prune early.
            // However, the problem constraints (num <= 10^8) make the current approach fast enough.
            // if sum_divisors > num {
            //     return false;
            // }
        }

        sum_divisors == num
    }
}