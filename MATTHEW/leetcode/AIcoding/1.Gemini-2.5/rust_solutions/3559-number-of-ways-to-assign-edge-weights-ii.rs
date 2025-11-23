struct Solution;

const MOD: i64 = 1_000_000_007;
const N_MAX_FOR_COMB: usize = 1000; // Max value for k-1 (path length - 1), where k is at most n-1. So max index is n-2.
                                     // N_MAX_FOR_COMB = 1000 allows indices 0 to 999, sufficient for n up to 1000.

static mut FACT: [i64; N_MAX_FOR_COMB] = [0; N_MAX_FOR_COMB];
static mut INV_FACT: [i64; N_MAX_FOR_COMB] = [0; N_MAX_FOR_COMB];
static mut PRECOMPUTED: bool = false;

fn power(mut base: i64, mut exp: i64) -> i64 {
    let mut res = 1;
    base %= MOD;
    while exp > 0 {
        if exp % 2 == 1 {
            res = (res * base) % MOD;
        }
        base = (base * base) % MOD;
        exp /= 2;
    }
    res
}

fn inv(n: i64) -> i64 {
    power(n, MOD - 2)
}

fn precompute_factorials() {
    unsafe {
        if PRECOMPUTED { return; }

        FACT[0] = 1;
        for i in 1..N_MAX_FOR_COMB {
            FACT[i] = (FACT[i - 1] * i as i64) % MOD;
        }
        INV_FACT[N_MAX_FOR_COMB - 1] = inv(FACT[N_MAX_FOR_COMB - 1]);
        for i in (0..N_MAX_FOR_COMB - 1).rev() {
            INV_FACT[i] = (INV_FACT[i + 1] * (i + 1) as i64) % MOD;
        }
        PRECOMPUTED = true;
    }
}

fn ncr_mod_p(n: i64, r: i64) -> i64 {
    if r < 0 || r > n {
        return 0;
    }
    if r == 0 || r == n {
        return 1;
    }

    let mut res = 1;
    unsafe {
        for i in 0..r {
            res = (res * ((n - i) % MOD)) % MOD;
        }
        res = (res * INV_FACT[r as usize]) % MOD;
    }
    res
}

struct LCA {
    adj: Vec<Vec<usize>>,
    depth: Vec<usize>,
    parent: Vec<Vec<usize>>,
    n: usize,
    logn: usize,
}

impl LCA {
    fn new(n_nodes: usize, edges: &Vec<Vec<i32>>) -> Self {
        let mut adj = vec![vec![]; n_nodes];
        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            adj[u].push(v);
            adj[v].push(u);
        }

        let logn = (n_nodes as f64).log2().ceil() as usize + 1;
        let mut depth = vec![0; n_nodes];
        let mut parent = vec![vec![0; logn]; n_nodes];

        let mut lca_instance = LCA {
            adj,
            depth,
            parent,
            n: n_nodes,
            logn,
        };

        lca_instance.dfs(0, 0, 0); 
        lca_instance.build_lca_table();
        lca_instance
    }

    fn dfs(&mut self, u: usize, p: usize, d: usize) {
        self.depth[u] = d;
        self.parent[u][0] = p;
        for &v in &self.adj[u] {
            if v == p {
                continue;
            }
            self.dfs(v, u, d + 1);
        }
    }

    fn build_lca_table(&mut self) {
        for j in 1..self.logn {
            for i in 0..self.n {
                self.parent[i][j] = self.parent[self.parent[i][j - 1]][j - 1];
            }
        }
    }

    fn get_lca(&self, mut u: usize, mut v: usize) -> usize {
        if self.depth[u] < self.depth[v] {
            std::mem::swap(&mut u, &mut v);
        }

        for j in (0..self.logn).rev() {
            if self.depth[u] - (1 << j) >= self.depth[v] {
                u = self.parent[u][j];
            }
        }

        if u == v {
            return u;
        }

        for j in (0..self.logn).rev() {
            if self.parent[u][j] != self.parent[v][j] {
                u = self.parent[u][j];
                v = self.parent[v][j];
            }
        }
        self.parent[u][0]
    }
}

impl Solution {
    pub fn number_of_ways_to_assign_edge_weights_ii(n: i32, edges: Vec<Vec<i32>>, queries: Vec<Vec<i32>>) -> Vec<i32> {
        precompute_factorials();

        let n_usize = n as usize;
        let lca_solver = LCA::new(n_usize, &edges);

        let mut results = Vec::with_capacity(queries.len());

        for query in queries {
            let u = query[0] as usize;
            let v = query[1] as usize;
            let w = query[2] as i64;

            let lca_node = lca_solver.get_lca(u, v);
            let path_len = (lca_solver.depth[u] + lca_solver.depth[v] - 2 * lca_solver.depth[lca_node]) as i64;

            let ways = ncr_mod_p(w - 1, path_len - 1);
            results.push(ways as i32);
        }

        results
    }
}