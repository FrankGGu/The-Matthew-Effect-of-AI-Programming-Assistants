use std::collections::HashSet;

impl Solution {
    pub fn smallest_value(n: i32) -> i32 {
        let mut current_n = n;
        let mut visited = HashSet::new();
        let mut path = Vec::new(); // Store the sequence to find min in cycle

        loop {
            // If current_n is prime, the process stops.
            if Self::is_prime(current_n) {
                return current_n;
            }

            // Check for cycle detection
            if !visited.insert(current_n) {
                // current_n is already in 'visited', indicating a cycle has been entered.
                // The problem asks for the smallest value 'n' can take.
                // If a cycle is formed, the smallest value is the minimum within that cycle.
                let mut min_in_cycle = current_n; // Initialize with the value that closed the cycle
                let mut found_cycle_start = false;

                // Iterate through the 'path' to find the minimum value within the detected cycle.
                // The cycle starts from the first occurrence of 'current_n' in 'path'.
                for &val in &path {
                    if val == current_n {
                        found_cycle_start = true;
                    }
                    if found_cycle_start {
                        min_in_cycle = min_in_cycle.min(val);
                    }
                }
                return min_in_cycle;
            }

            // Add current_n to path for future cycle detection
            path.push(current_n);

            // Replace n with the sum of its prime factors
            current_n = Self::sum_prime_factors(current_n);
        }
    }

    // Helper function to check if a number is prime
    fn is_prime(n: i32) -> bool {
        if n <= 1 {
            return false;
        }
        if n <= 3 {
            return true; // 2 and 3 are prime
        }
        // Check if n is divisible by 2 or 3
        if n % 2 == 0 || n % 3 == 0 {
            return false;
        }
        // Check for primes of the form 6k +/- 1
        let mut i = 5;
        while i * i <= n {
            if n % i == 0 || n % (i + 2) == 0 {
                return false;
            }
            i += 6;
        }
        true
    }

    // Helper function to calculate the sum of prime factors with multiplicity
    fn sum_prime_factors(mut n: i32) -> i32 {
        if n <= 1 {
            // For n=0 or n=1, the sum of prime factors is conventionally 0,
            // as 1 has no prime factors and 0 is not a positive integer for prime factorization.
            // This handles cases like 1 -> 0 -> 0 -> ... where 0 is the smallest value.
            return 0;
        }

        let mut sum = 0;
        let mut d = 2;
        // Iterate up to sqrt(n) to find prime factors
        while d * d <= n {
            while n % d == 0 {
                sum += d;
                n /= d;
            }
            d += 1;
        }
        // If n is still greater than 1 after the loop, it means the remaining n is a prime factor itself
        if n > 1 {
            sum += n;
        }
        sum
    }
}