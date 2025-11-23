const MOD: i64 = 1_000_000_007;

impl Solution {
    pub fn count_ways(parents: Vec<i32>) -> i32 {
        let n = parents.len();
        let mut adj: Vec<Vec<usize>> = vec![Vec::new(); n];
        for (i, &p) in parents.iter().enumerate() {
            if p != -1 {
                adj[p as usize].push(i);
            }
        }

        let mut sizes = vec![0; n];
        let mut fact = vec![1; n + 1];
        let mut inv_fact = vec![1; n + 1];

        for i in 2..=n {
            fact[i] = (fact[i - 1] * i as i64) % MOD;
        }

        inv_fact[n] = Self::mod_inverse(fact[n], MOD);
        for i in (0..n).rev() {
            inv_fact[i] = (inv_fact[i + 1] * (i + 1) as i64) % MOD;
        }

        fn dfs(u: usize, adj: &Vec<Vec<usize>>, sizes: &mut Vec<usize>) -> i64 {
            sizes[u] = 1;
            let mut result = 1;
            for &v in &adj[u] {
                result = (result * dfs(v, adj, sizes)) % MOD;
                sizes[u] += sizes[v];
            }
            result
        }

        let ways = dfs(0, &adj, &mut sizes);

        let mut comb_prod = 1;
        for i in 0..n {
            comb_prod = (comb_prod * inv_fact[sizes[i]]) % MOD;
        }

        ((ways * comb_prod) % MOD * fact[n] % MOD) as i32
    }

    fn mod_inverse(a: i64, m: i64) -> i64 {
        Self::power(a, m - 2, m)
    }

    fn power(mut base: i64, mut exp: i64, modulus: i64) -> i64 {
        let mut result = 1;
        base %= modulus;
        while exp > 0 {
            if exp % 2 == 1 {
                result = (result * base) % modulus;
            }
            base = (base * base) % modulus;
            exp /= 2;
        }
        result
    }
}