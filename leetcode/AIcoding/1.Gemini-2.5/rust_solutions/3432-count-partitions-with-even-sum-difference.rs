impl Solution {
    pub fn count_partitions_with_even_sum_difference(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let modulo: i64 = 1_000_000_007;

        if n == 0 {
            // For an empty array, there is one partition ({}, {}).
            // sum({}) = 0, sum({}) = 0. Difference = 0, which is even.
            return 1;
        }

        let total_sum: i64 = nums.iter().map(|&x| x as i64).sum();

        // The problem "Count Partitions with Even Sum Difference" is often interpreted
        // as counting partitions (S1, S2) such that sum(S1) is even and sum(S2) is even.
        // If sum(S1) is even and sum(S2) is even, then sum(S1) - sum(S2) is even.
        // Also, total_sum = sum(S1) + sum(S2) must be even.
        // If total_sum is odd, it's impossible for both sum(S1) and sum(S2) to be even.
        // If total_sum is even, then sum(S1) being even implies sum(S2) is also even.
        // So the problem reduces to:
        // 1. If total_sum is odd, return 0.
        // 2. If total_sum is even, count the number of subsets S1 whose sum is even.

        if total_sum % 2 != 0 {
            return 0;
        }

        // total_sum is even.
        // Now we need to count the number of subsets with an even sum.
        // This can be determined by the count of odd numbers in `nums`.
        let mut n_odd_elements = 0;
        for &num in &nums {
            if num % 2 != 0 {
                n_odd_elements += 1;
            }
        }

        if n_odd_elements == 0 {
            // If all numbers are even, any subset sum will be even.
            // There are 2^N subsets.
            Self::power(2, n as i64, modulo) as i32
        } else {
            // If there is at least one odd number, then exactly half of the subsets
            // will have an even sum, and the other half will have an odd sum.
            // So, there are 2^(N-1) subsets with an even sum.
            Self::power(2, (n - 1) as i64, modulo) as i32
        }
    }

    // Modular exponentiation function: (base^exp) % modulus
    fn power(mut base: i64, mut exp: i64, modulus: i64) -> i64 {
        let mut res = 1;
        base %= modulus;
        while exp > 0 {
            if exp % 2 == 1 {
                res = (res * base) % modulus;
            }
            base = (base * base) % modulus;
            exp /= 2;
        }
        res
    }
}