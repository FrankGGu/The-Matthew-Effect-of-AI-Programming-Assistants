impl Solution {
    pub fn beautiful_bouquet(flowers: Vec<i32>, k: i32) -> i32 {
        let n = flowers.len();
        let k = k as usize;
        let mut left = 0;
        let mut ans = 0;
        let mut count = std::collections::HashMap::new();
        let mod_val = 1_000_000_007;
        let mut fact = vec![1; n + 1];
        let mut inv = vec![1; n + 1];

        for i in 2..=n {
            fact[i] = (fact[i - 1] as i64 * i as i64 % mod_val as i64) as i32;
        }

        inv[n] = Self::power(fact[n], mod_val - 2, mod_val);
        for i in (1..n).rev() {
            inv[i] = (inv[i + 1] as i64 * (i + 1) as i64 % mod_val as i64) as i32;
        }

        fn power(mut base: i32, mut exp: i32, mod_val: i32) -> i32 {
            let mut res = 1;
            base %= mod_val;
            while exp > 0 {
                if exp % 2 == 1 {
                    res = (res as i64 * base as i64 % mod_val as i64) as i32;
                }
                base = (base as i64 * base as i64 % mod_val as i64) as i32;
                exp >>= 1;
            }
            res
        }

        fn combination(n: usize, k: usize, fact: &Vec<i32>, inv: &Vec<i32>, mod_val: i32) -> i32 {
            if k > n {
                return 0;
            }
            (fact[n] as i64 * inv[k] as i64 % mod_val as i64 * inv[n - k] as i64 % mod_val as i64) as i32
        }

        for right in 0..n {
            *count.entry(flowers[right]).or_insert(0) += 1;
            while *count.values().max().unwrap() as usize > k {
                *count.entry(flowers[left]).or_insert(0) -= 1;
                if count[&flowers[left]] == 0 {
                    count.remove(&flowers[left]);
                }
                left += 1;
            }

            let len = right - left + 1;
            ans = (ans as i64 + fact[len] as i64) % mod_val as i64;

            let mut inv_val = 1;
            for &c in count.values() {
                inv_val = (inv_val as i64 * inv[c as usize] as i64 % mod_val as i64) as i32;
            }

            ans = (ans as i64 - (ans as i64 * inv_val as i64 % mod_val as i64 * fact[count.len()] as i64 % mod_val as i64) + mod_val as i64) % mod_val as i64;
        }

        ans as i32
    }
}