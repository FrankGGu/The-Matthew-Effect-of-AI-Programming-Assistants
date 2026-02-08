impl Solution {
    pub fn sub_str_hash(s: String, k: i32, power: i32, modulo: i32, hash_value: i32) -> String {
        let n = s.len();
        let k = k as usize;
        let p = power as i64;
        let m = modulo as i64;
        let target_hash = hash_value as i64;
        let s_bytes = s.as_bytes();

        // Helper function for modular exponentiation (base^exp % modulus)
        // This is a standard implementation for modular exponentiation,
        // used for calculating p^(k-1) and p_inv efficiently.
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

        // Calculate modular inverse of p: p^(m-2) % m using Fermat's Little Theorem.
        // This is valid because `modulo` is prime and `power` is not a multiple of `modulo`
        // (given 1 <= power < modulo).
        let p_inv = power(p, m - 2, m);

        // Calculate p^(k-1) % m, which is needed for adding the new character at the most significant position.
        let pk_minus_1 = power(p, k as i64 - 1, m);

        let mut current_hash: i64 = 0;
        let mut p_power_val: i64 = 1; // Represents p^j for the j-th character in the window (0-indexed)

        // Calculate the hash for the first window s[0...k-1]
        for j in 0..k {
            let char_val = (s_bytes[j] - b'a' + 1) as i64;
            current_hash = (current_hash + char_val * p_power_val) % m;
            p_power_val = (p_power_val * p) % m;
        }

        // If the hash of the first window matches the target, it's the leftmost.
        if current_hash == target_hash {
            return s[0..k].to_string();
        }

        // Slide the window from left to right for subsequent windows.
        // `i` represents the starting index of the current window.
        for i in 1..=(n - k) {
            // Remove the character s[i-1] from the hash.
            // (current_hash - val(s[i-1])*p^0)
            let char_to_remove_val = (s_bytes[i - 1] - b'a' + 1) as i64;
            current_hash = (current_hash - char_to_remove_val + m) % m; // Ensure positive result

            // Divide the remaining hash by p (multiply by p_inv).
            // This effectively shifts the powers down: p^1 -> p^0, p^2 -> p^1, etc.
            current_hash = (current_hash * p_inv) % m;

            // Add the new character s[i+k-1] to the hash at the highest power position (p^(k-1)).
            let char_to_add_val = (s_bytes[i + k - 1] - b'a' + 1) as i64;
            current_hash = (current_hash + char_to_add_val * pk_minus_1) % m;

            // If the hash of the current window matches the target, it's the leftmost
            // match found so far (since we are iterating from left to right).
            if current_hash == target_hash {
                return s[i..(i + k)].to_string();
            }
        }

        // According to LeetCode problem constraints and typical problem guarantees,
        // a matching substring is always expected to be found.
        // This line should theoretically not be reached.
        unreachable!(); 
    }
}