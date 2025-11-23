impl Solution {
    pub fn make_string_sorted(s: String) -> i32 {
        let n = s.len();
        let mut chars: Vec<u8> = s.into_bytes();
        let mut fact: Vec<i64> = vec![1; n + 1];
        let mut inv: Vec<i64> = vec![1; n + 1];
        let mod_val: i64 = 1_000_000_007;

        for i in 1..=n {
            fact[i] = (fact[i - 1] * i as i64) % mod_val;
        }

        inv[n] = Self::power(fact[n], mod_val - 2, mod_val);
        for i in (1..=n).rev() {
            inv[i - 1] = (inv[i] * i as i64) % mod_val;
        }

        let mut ans: i64 = 0;
        for i in 0..n {
            let mut count: Vec<i32> = vec![0; 26];
            for j in i + 1..n {
                count[(chars[j] - b'a') as usize] += 1;
            }

            let mut smaller: i64 = 0;
            for j in 0..(chars[i] - b'a') as usize {
                smaller += count[j] as i64;
            }

            let mut denom: i64 = 1;
            for k in 0..26 {
                denom = (denom * fact[count[k] as usize]) % mod_val;
            }

            ans = (ans + (fact[n - i - 1] * Self::power(denom, mod_val - 2, mod_val) % mod_val) * smaller % mod_val) % mod_val;
            chars[i as usize] = 0; // Mark as used
            for j in i + 1..n{
                 if chars[j] != 0 && chars[j] == chars[i] {
                     chars[j] = 0;
                 }
            }

        }

        ans as i32
    }

    fn power(mut base: i64, mut exp: i64, modulus: i64) -> i64 {
        let mut res: i64 = 1;
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