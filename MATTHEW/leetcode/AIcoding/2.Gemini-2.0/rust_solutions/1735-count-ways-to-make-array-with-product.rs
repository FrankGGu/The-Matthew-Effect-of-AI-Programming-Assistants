impl Solution {
    pub fn ways_to_fill_array(queries: Vec<Vec<i32>>) -> Vec<i32> {
        let mod_val = 1_000_000_007;
        let max_n = 10001;
        let mut factorial = vec![1; max_n];
        let mut inv_factorial = vec![1; max_n];

        for i in 2..max_n {
            factorial[i] = (factorial[i - 1] as i64 * i as i64 % mod_val as i64) as i32;
        }

        inv_factorial[max_n - 1] = Self::power(factorial[max_n - 1] as i64, mod_val as i64 - 2, mod_val as i64) as i32;
        for i in (0..max_n - 1).rev() {
            inv_factorial[i] = (inv_factorial[i + 1] as i64 * (i + 1) as i64 % mod_val as i64) as i32;
        }

        let mut result = Vec::new();
        for query in queries {
            let n = query[0] as usize;
            let k = query[1];

            let mut factors = Vec::new();
            let mut num = k;
            for i in 2..=(k as f64).sqrt() as i32 + 1 {
                while num % i == 0 {
                    factors.push(i);
                    num /= i;
                }
            }
            if num > 1 {
                factors.push(num);
            }

            let mut counts = std::collections::HashMap::new();
            for &factor in &factors {
                *counts.entry(factor).or_insert(0) += 1;
            }

            let mut m = 0;
            for &count in counts.values() {
                m += count;
            }

            let comb = Self::combinations(n + m - 1, m, &factorial, &inv_factorial, mod_val);
            result.push(comb);
        }

        result
    }

    fn combinations(n: usize, k: usize, factorial: &Vec<i32>, inv_factorial: &Vec<i32>, mod_val: i32) -> i32 {
        if k > n {
            return 0;
        }
        let numerator = factorial[n] as i64;
        let denominator = (inv_factorial[k] as i64 * inv_factorial[n - k] as i64) % mod_val as i64;
        (numerator * denominator % mod_val as i64) as i32
    }

    fn power(base: i64, exp: i64, mod_val: i64) -> i32 {
        let mut res = 1;
        let mut b = base % mod_val;
        let mut e = exp;

        while e > 0 {
            if e % 2 == 1 {
                res = (res * b) % mod_val;
            }
            b = (b * b) % mod_val;
            e /= 2;
        }

        res as i32
    }
}