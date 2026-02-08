impl Solution {
    pub fn ways_to_fill_array(queries: Vec<Vec<i32>>) -> Vec<i32> {
        const MOD: i32 = 1_000_000_007;
        const MAX_N: usize = 10000 + 13;
        const MAX_K: usize = 10000 + 13;

        let mut min_prime = vec![0; MAX_K];
        for i in 2..MAX_K {
            if min_prime[i] == 0 {
                min_prime[i] = i as i32;
                for j in (i * i..MAX_K).step_by(i) {
                    if min_prime[j] == 0 {
                        min_prime[j] = i as i32;
                    }
                }
            }
        }

        let mut comb = vec![vec![0; 20]; MAX_N];
        for i in 0..MAX_N {
            comb[i][0] = 1;
            if i < 20 {
                comb[i][i] = 1;
            }
            for j in 1..std::cmp::min(i, 20) {
                comb[i][j] = (comb[i - 1][j - 1] + comb[i - 1][j]) % MOD;
            }
        }

        let mut res = Vec::with_capacity(queries.len());
        for query in queries {
            let (n, k) = (query[0] as usize, query[1] as usize);
            if k == 1 {
                res.push(1);
                continue;
            }
            let mut ans = 1i64;
            let mut x = k;
            while x > 1 {
                let p = min_prime[x] as usize;
                let mut cnt = 0;
                while x % p == 0 {
                    x /= p;
                    cnt += 1;
                }
                ans = (ans * comb[n + cnt - 1][cnt] as i64) % MOD as i64;
            }
            res.push(ans as i32);
        }
        res
    }
}