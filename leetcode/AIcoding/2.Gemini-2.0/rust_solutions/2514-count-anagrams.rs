impl Solution {
    pub fn count_anagrams(s: String) -> i32 {
        let words: Vec<&str> = s.split_whitespace().collect();
        let n = words.len();
        let mut ans: i64 = 1;
        let mut total_len: usize = 0;
        let mod_val: i64 = 1_000_000_007;

        let mut fact: Vec<i64> = vec![1; 100001];
        for i in 2..100001 {
            fact[i] = (fact[i - 1] * i as i64) % mod_val;
        }

        for word in words {
            total_len += word.len();
            let mut counts: std::collections::HashMap<char, usize> = std::collections::HashMap::new();
            for c in word.chars() {
                *counts.entry(c).or_insert(0) += 1;
            }

            let mut denominator: i64 = 1;
            for (_, count) in counts {
                denominator = (denominator * fact[count]) % mod_val;
            }

            ans = (ans * fact[word.len()]) % mod_val;
            ans = (ans * Self::power(denominator, mod_val - 2, mod_val)) % mod_val;
        }

        ans as i32
    }

    fn power(base: i64, exp: i64, mod_val: i64) -> i64 {
        let mut res: i64 = 1;
        let mut b = base % mod_val;
        let mut e = exp;

        while e > 0 {
            if e % 2 == 1 {
                res = (res * b) % mod_val;
            }
            b = (b * b) % mod_val;
            e /= 2;
        }

        res
    }
}