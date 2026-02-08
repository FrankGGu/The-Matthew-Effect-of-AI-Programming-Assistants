use std::collections::HashMap;

impl Solution {
    pub fn count_k_subsequences_with_max_beauty(s: String, k: i32) -> i32 {
        let k = k as usize;
        if k == 0 {
            return 0;
        }
        let mut freq = HashMap::new();
        for c in s.chars() {
            *freq.entry(c).or_insert(0) += 1;
        }
        if freq.len() < k {
            return 0;
        }
        let mut counts: Vec<i32> = freq.values().cloned().collect();
        counts.sort_unstable_by(|a, b| b.cmp(a));
        let m = 1_000_000_007;
        let mut res = 1i64;
        let last = counts[k - 1];
        let mut total_last = 0;
        let mut selected = 0;
        for &cnt in counts.iter() {
            if cnt > last {
                res = (res * cnt as i64) % m;
                selected += 1;
            } else if cnt == last {
                total_last += 1;
            }
        }
        let remaining = k - selected;
        if remaining > 0 {
            let comb = Self::combination(total_last as i64, remaining as i64, m);
            res = (res * comb) % m;
            for _ in 0..remaining {
                res = (res * last as i64) % m;
            }
        }
        res as i32
    }

    fn combination(n: i64, k: i64, m: i64) -> i64 {
        if k > n {
            return 0;
        }
        if k == 0 || k == n {
            return 1;
        }
        let k = std::cmp::min(k, n - k);
        let mut res = 1;
        for i in 1..=k {
            res = res * (n - k + i) % m;
            res = res * Self::mod_inverse(i, m) % m;
        }
        res
    }

    fn mod_inverse(a: i64, m: i64) -> i64 {
        let mut a = a;
        let mut m = m;
        let mut x0 = 0;
        let mut x1 = 1;
        while a > 1 {
            let q = a / m;
            let tmp = m;
            m = a % m;
            a = tmp;
            let tmp = x0;
            x0 = x1 - q * x0;
            x1 = tmp;
        }
        if x1 < 0 {
            x1 += m;
        }
        x1
    }
}