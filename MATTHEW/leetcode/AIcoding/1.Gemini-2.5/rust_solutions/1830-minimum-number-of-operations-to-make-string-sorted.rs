struct Solution;

impl Solution {
    const MOD: i64 = 1_000_000_007;

    fn pow(base: i64, mut exp: i64) -> i64 {
        let mut res = 1;
        let mut base = base % Self::MOD;
        while exp > 0 {
            if exp % 2 == 1 {
                res = (res * base) % Self::MOD;
            }
            base = (base * base) % Self::MOD;
            exp /= 2;
        }
        res
    }

    pub fn min_operations_to_make_string_sorted(s: String) -> i32 {
        let n = s.len();
        let s_bytes = s.as_bytes();

        let mut fact = vec![1; n + 1];
        let mut inv_fact = vec![1; n + 1];

        for i in 1..=n {
            fact[i] = (fact[i - 1] * i as i64) % Self::MOD;
        }

        inv_fact[n] = Self::pow(fact[n], Self::MOD - 2);
        for i in (1..n).rev() {
            inv_fact[i] = (inv_fact[i + 1] * (i + 1) as i64) % Self::MOD;
        }
        // inv_fact[0] is 1, which is correct for 0!

        let mut counts = vec![0; 26];
        for &c in s_bytes {
            counts[(c - b'a') as usize] += 1;
        }

        let mut ans = 0;
        for i in 0..n {
            let current_char_idx = (s_bytes[i] - b'a') as usize;

            // Calculate (n-1-i)! / (counts[0]! * counts[1]! * ...)
            // This is the number of permutations of the remaining characters
            let mut current_permutations_base = fact[n - 1 - i];

            for j in 0..26 {
                current_permutations_base = (current_permutations_base * inv_fact[counts[j]]) % Self::MOD;
            }

            // Sum up permutations for smaller characters at current_char_idx
            // For each character smaller than s[i] that could be placed at s[i],
            // calculate the number of permutations of the remaining characters.
            let mut num_smaller_chars_sum = 0;
            for j in 0..current_char_idx {
                num_smaller_chars_sum = (num_smaller_chars_sum + counts[j]) % Self::MOD;
            }

            let term = (num_smaller_chars_sum * current_permutations_base) % Self::MOD;
            ans = (ans + term) % Self::MOD;

            // Update counts for the next iteration
            counts[current_char_idx] -= 1;
        }

        ans as i32
    }
}