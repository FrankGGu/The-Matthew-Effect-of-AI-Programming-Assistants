struct Solution;

impl Solution {
    const MOD: i64 = 1_000_000_007;

    fn power(mut base: i64, mut exp: i64) -> i64 {
        let mut res = 1;
        base %= Self::MOD;
        while exp > 0 {
            if exp % 2 == 1 {
                res = (res * base) % Self::MOD;
            }
            base = (base * base) % Self::MOD;
            exp /= 2;
        }
        res
    }

    fn inv(n: i64) -> i64 {
        Self::power(n, Self::MOD - 2)
    }

    fn precompute_factorials(n: usize) -> (Vec<i64>, Vec<i64>) {
        let mut fact = vec![0; n + 1];
        let mut inv_fact = vec![0; n + 1];
        fact[0] = 1;
        inv_fact[0] = 1;
        for i in 1..=n {
            fact[i] = (fact[i - 1] * i as i64) % Self::MOD;
        }
        inv_fact[n] = Self::inv(fact[n]);
        for i in (1..n).rev() {
            inv_fact[i] = (inv_fact[i + 1] * (i + 1) as i64) % Self::MOD;
        }
        (fact, inv_fact)
    }

    fn dfs(
        u: usize,
        adj: &[Vec<usize>],
        fact: &[i64],
        inv_fact: &[i64],
        memo: &mut Vec<Option<(i64, i64)>>, // (subtree_size, ways_to_build_subtree)
    ) -> (i64, i64) {
        if let Some(result) = memo[u] {
            return result;
        }

        let mut current_size: i64 = 1;
        let mut current_ways: i64 = 1;
        let mut inv_fact_product: i64 = 1;

        for &v in &adj[u] {
            let (child_size, child_ways) = Self::dfs(v, adj, fact, inv_fact, memo);
            current_size += child_size;
            current_ways = (current_ways * child_ways) % Self::MOD;
            inv_fact_product = (inv_fact_product * inv_fact[child_size as usize]) % Self::MOD;
        }

        current_ways = (current_ways * fact[(current_size - 1) as usize]) % Self::MOD;
        current_ways = (current_ways * inv_fact_product) % Self::MOD;

        memo[u] = Some((current_size, current_ways));
        (current_size, current_ways)
    }

    pub fn ways_to_build_rooms(prev_room: Vec<i32>) -> i32 {
        let n = prev_room.len();
        let mut adj: Vec<Vec<usize>> = vec![vec![]; n];

        for i in 1..n {
            adj[prev_room[i] as usize].push(i);
        }

        let (fact, inv_fact) = Self::precompute_factorials(n);
        let mut memo: Vec<Option<(i64, i64)>> = vec![None; n];

        let (_, total_ways) = Self::dfs(0, &adj, &fact, &inv_fact, &mut memo);

        total_ways as i32
    }
}