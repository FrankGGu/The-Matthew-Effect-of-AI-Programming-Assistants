impl Solution {

use std::collections::HashMap;

struct Solution;

impl Solution {
    pub fn ways_to_build_rooms(orders: Vec<i32>) -> i32 {
        const MOD: i64 = 1_000_000_007;
        let n = orders.len();
        let mut graph = vec![vec![]; n];
        let mut in_degree = vec![0; n];

        for &order in &orders {
            let parent = order as usize;
            let child = (parent + 1) % n;
            graph[parent].push(child);
            in_degree[child] += 1;
        }

        let mut queue = std::collections::VecDeque::new();
        for i in 0..n {
            if in_degree[i] == 0 {
                queue.push_back(i);
            }
        }

        let mut post_order = vec![0; n];
        let mut size = vec![1; n];
        let mut fact = vec![1; n + 1];

        for i in 1..=n {
            fact[i] = fact[i - 1] * i % MOD;
        }

        while let Some(u) = queue.pop_front() {
            for &v in &graph[u] {
                in_degree[v] -= 1;
                if in_degree[v] == 0 {
                    queue.push_back(v);
                }
            }
            post_order[u] = 1;
            for &v in &graph[u] {
                post_order[u] = (post_order[u] + post_order[v]) % MOD;
                size[u] += size[v];
            }
        }

        let mut dp = vec![0; n];
        let mut memo = HashMap::new();

        fn dfs(
            u: usize,
            size: &[i32],
            post_order: &[i32],
            fact: &[i64],
            memo: &mut HashMap<usize, i64>,
            MOD: i64,
        ) -> i64 {
            if memo.contains_key(&u) {
                return *memo.get(&u).unwrap();
            }

            let mut res = 1;
            for &v in &graph[u] {
                res = res * dfs(v, size, post_order, fact, memo, MOD) % MOD;
                res = res * fact[size[u] as usize - 1] % MOD;
                res = res * pow(fact[size[v] as usize], MOD - 2, MOD) % MOD;
                size[u] -= size[v];
            }

            memo.insert(u, res);
            res
        }

        for i in 0..n {
            if in_degree[i] == 0 {
                dfs(i, &size, &post_order, &fact, &mut memo, MOD);
            }
        }

        memo.get(&0).copied().unwrap_or(0) as i32
    }

    fn pow(a: i64, b: i64, mod_val: i64) -> i64 {
        let mut result = 1;
        let mut base = a;
        let mut exponent = b;
        while exponent > 0 {
            if exponent % 2 == 1 {
                result = result * base % mod_val;
            }
            base = base * base % mod_val;
            exponent /= 2;
        }
        result
    }
}
}