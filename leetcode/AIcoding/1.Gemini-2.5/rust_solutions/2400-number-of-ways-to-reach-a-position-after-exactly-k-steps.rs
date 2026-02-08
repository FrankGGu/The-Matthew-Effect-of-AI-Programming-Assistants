struct Solution;

impl Solution {
    pub fn number_of_ways(start_pos: i32, end_pos: i32, k: i32) -> i32 {
        let diff = (end_pos - start_pos).abs();

        if diff > k {
            return 0;
        }

        if (k - diff) % 2 != 0 {
            return 0;
        }

        let num_forward_steps = (k + diff) / 2;
        let num_backward_steps = (k - diff) / 2;

        let n = k;
        let r = num_forward_steps;

        let modulo: i64 = 1_000_000_007;

        let mut fact = vec![0; (n + 1) as usize];
        fact[0] = 1;
        for i in 1..=(n as usize) {
            fact[i] = (fact[i - 1] as i64 * i as i64) % modulo;
        }

        fn power(base: i64, exp: i64, modulus: i64) -> i64 {
            let mut res = 1;
            let mut base = base % modulus;
            let mut exp = exp;
            while exp > 0 {
                if exp % 2 == 1 {
                    res = (res * base) % modulus;
                }
                base = (base * base) % modulus;
                exp /= 2;
            }
            res
        }

        fn mod_inverse(n: i64, modulus: i64) -> i64 {
            power(n, modulus - 2, modulus)
        }

        let numerator = fact[n as usize];
        let denominator_r = fact[r as usize];
        let denominator_nr = fact[(n - r) as usize];

        let inv_denominator_r = mod_inverse(denominator_r, modulo);
        let inv_denominator_nr = mod_inverse(denominator_nr, modulo);

        let result = (numerator as i64 * inv_denominator_r) % modulo;
        let result = (result * inv_denominator_nr) % modulo;

        result as i32
    }
}