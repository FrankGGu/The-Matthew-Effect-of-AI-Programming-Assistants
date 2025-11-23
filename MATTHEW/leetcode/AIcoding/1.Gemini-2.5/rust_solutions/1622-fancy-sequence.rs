struct Fancy {
    nums: Vec<(i64, i64, i64)>, // Stores (original_value, global_s_at_append, global_a_at_append)
    global_s: i64, // Current global multiplier
    global_a: i64, // Current global adder
    modulus: i64,
}

impl Fancy {
    fn new() -> Self {
        Fancy {
            nums: Vec::new(),
            global_s: 1,
            global_a: 0,
            modulus: 1_000_000_007,
        }
    }

    // Modular exponentiation (base^exp % modulus)
    fn power(&self, mut base: i64, mut exp: i64) -> i64 {
        let mut res = 1;
        base %= self.modulus;
        while exp > 0 {
            if exp % 2 == 1 {
                res = (res * base) % self.modulus;
            }
            base = (base * base) % self.modulus;
            exp /= 2;
        }
        res
    }

    // Modular multiplicative inverse using Fermat's Little Theorem (a^(MOD-2) % MOD)
    fn mod_inv(&self, n: i64) -> i64 {
        self.power(n, self.modulus - 2)
    }

    fn append(&mut self, val: i32) {
        // Store the original value along with the global transformation state at the time of append.
        self.nums.push((val as i64, self.global_s, self.global_a));
    }

    fn add_all(&mut self, inc: i32) {
        // Update the global adder
        self.global_a = (self.global_a + inc as i64) % self.modulus;
    }

    fn mult_all(&mut self, m: i32) {
        // Update both global multiplier and adder
        self.global_s = (self.global_s * m as i64) % self.modulus;
        self.global_a = (self.global_a * m as i64) % self.modulus;
    }

    fn get(&mut self, idx: i32) -> i32 {
        let idx = idx as usize;
        if idx >= self.nums.len() {
            return -1;
        }

        // If global_s is 0, it means all numbers have been multiplied by 0 at some point.
        // In this case, their base value became 0, and then only additions apply.
        // So, the final value for any element is simply global_a.
        if self.global_s == 0 {
            return self.global_a as i32;
        }

        let (original_val, s_at_append, a_at_append) = self.nums[idx];

        // The current global transformation is (global_s, global_a).
        // The transformation at the time of append was (s_at_append, a_at_append).
        // We need to find the transformation (S_prime, A_prime) such that:
        // current_value = (original_val * S_prime + A_prime) % MOD
        //
        // The relationship between transformations is:
        // f_current(x) = f_prime(f_append(x))
        // global_s * x + global_a = S_prime * (s_at_append * x + a_at_append) + A_prime
        // global_s * x + global_a = (S_prime * s_at_append) * x + (S_prime * a_at_append + A_prime)
        //
        // Comparing coefficients:
        // 1) global_s = S_prime * s_at_append
        // 2) global_a = S_prime * a_at_append + A_prime
        //
        // From (1): S_prime = global_s * s_at_append_inv (mod MOD)
        // From (2): A_prime = (global_a - S_prime * a_at_append + MOD) % MOD

        // If global_s is not 0, then s_at_append must also be not 0.
        // (If s_at_append were 0, then global_s would also be 0, which is handled above).
        // So, s_at_append_inv is guaranteed to exist.
        let s_at_append_inv = self.mod_inv(s_at_append);

        let s_prime = (self.global_s * s_at_append_inv) % self.modulus;

        let term = (s_prime * a_at_append) % self.modulus;
        let a_prime = (self.global_a - term + self.modulus) % self.modulus;

        let result = (original_val * s_prime + a_prime) % self.modulus;
        result as i32
    }
}