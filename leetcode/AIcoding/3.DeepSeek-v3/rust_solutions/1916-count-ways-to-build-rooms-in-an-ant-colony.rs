const MOD: i64 = 1_000_000_007;

impl Solution {
    pub fn ways_to_build_rooms(prev_room: Vec<i32>) -> i32 {
        let n = prev_room.len();
        let mut graph = vec![vec![]; n];
        for i in 1..n {
            let p = prev_room[i] as usize;
            graph[p].push(i);
        }

        let mut fact = vec![1; n + 1];
        let mut inv_fact = vec![1; n + 1];
        for i in 1..=n {
            fact[i] = (fact[i - 1] * i as i64) % MOD;
        }
        inv_fact[n] = Self::inv(fact[n]);
        for i in (1..n).rev() {
            inv_fact[i] = (inv_fact[i + 1] * (i + 1) as i64) % MOD;
        }

        let (res, _) = Self::dfs(0, &graph, &fact, &inv_fact);
        res as i32
    }

    fn dfs(u: usize, graph: &Vec<Vec<usize>>, fact: &Vec<i64>, inv_fact: &Vec<i64>) -> (i64, i64) {
        let mut res = 1;
        let mut total = 0;
        let mut sizes = vec![];
        for &v in &graph[u] {
            let (r, s) = Self::dfs(v, graph, fact, inv_fact);
            res = (res * r) % MOD;
            sizes.push(s);
            total += s;
        }
        let mut ways = fact[total as usize];
        for &s in &sizes {
            ways = (ways * inv_fact[s as usize]) % MOD;
        }
        res = (res * ways) % MOD;
        (res, total + 1)
    }

    fn inv(mut a: i64) -> i64 {
        let mut res = 1;
        let mut b = MOD - 2;
        while b > 0 {
            if b % 2 == 1 {
                res = (res * a) % MOD;
            }
            a = (a * a) % MOD;
            b /= 2;
        }
        res
    }
}