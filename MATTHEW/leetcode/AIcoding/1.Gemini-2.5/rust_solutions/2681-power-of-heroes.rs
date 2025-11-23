impl Solution {
    fn power(base: i64, exp: i64, modulus: i64) -> i64 {
        let mut result = 1;
        let mut base = base % modulus;
        let mut exp = exp;
        while exp > 0 {
            if exp % 2 == 1 {
                result = (result * base) % modulus;
            }
            base = (base * base) % modulus;
            exp /= 2;
        }
        result
    }

    pub fn sum_of_powers(mut nums: Vec<i32>) -> i32 {
        let n = nums.len();
        if n == 0 {
            return 0;
        }

        nums.sort_unstable();

        let modulus: i64 = 1_000_000_007;
        let inv2 = Self::power(2, modulus - 2, modulus);

        let mut total_power: i64 = 0;
        let mut sum_prefix_terms: i64 = 0; // Represents sum_{k=0}^{i-1} (nums[k]^2 * (2^k)^{-1})
        let mut current_pow2: i64 = 1; // Represents 2^i
        let mut current_inv_pow2: i64 = 1; // Represents (2^i)^{-1}

        for i in 0..n {
            let num_i = nums[i] as i64;

            // 1. Contribution from teams where nums[i] is both min and max (team is just {nums[i]})
            // Power = nums[i] * nums[i]^2 = nums[i]^3
            let term_j_eq_i = (num_i * num_i % modulus * num_i % modulus) % modulus;
            total_power = (total_power + term_j_eq_i) % modulus;

            // 2. Contribution from teams where nums[i] is max and nums[j] is min (j < i)
            // For a fixed nums[i] as max, and nums[j] as min:
            // Power = nums[i] * nums[j]^2 * 2^(i - j - 1)
            // Summing over j from 0 to i-1:
            // = nums[i] * sum_{j=0}^{i-1} (nums[j]^2 * 2^(i - j - 1))
            // This can be rewritten as:
            // = nums[i] * 2^(i-1) * sum_{j=0}^{i-1} (nums[j]^2 * (2^j)^{-1})
            // The `sum_{j=0}^{i-1} (nums[j]^2 * (2^j)^{-1})` part is `sum_prefix_terms`.
            // The `2^(i-1)` part can be derived from `current_pow2` (which is 2^i) by multiplying with `inv2`.
            if i > 0 {
                let pow2_i_minus_1 = (current_pow2 * inv2) % modulus;
                let term_j_lt_i = (num_i * pow2_i_minus_1 % modulus * sum_prefix_terms % modulus) % modulus;
                total_power = (total_power + term_j_lt_i) % modulus;
            }

            // 3. Update sum_prefix_terms for the next iteration (i+1)
            // For the next iteration, sum_prefix_terms will include the term for nums[i]
            // P_{i+1} = P_i + nums[i]^2 * (2^i)^{-1}
            let num_i_sq = (num_i * num_i) % modulus;
            let term_to_add_to_sum = (num_i_sq * current_inv_pow2) % modulus;
            sum_prefix_terms = (sum_prefix_terms + term_to_add_to_sum) % modulus;

            // 4. Update current_pow2 and current_inv_pow2 for the next iteration (i+1)
            current_pow2 = (current_pow2 * 2) % modulus;
            current_inv_pow2 = (current_inv_pow2 * inv2) % modulus;
        }

        total_power as i32
    }
}