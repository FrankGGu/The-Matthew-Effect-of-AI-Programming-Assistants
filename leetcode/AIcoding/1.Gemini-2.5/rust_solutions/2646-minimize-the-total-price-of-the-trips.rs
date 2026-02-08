use std::cmp::max;

struct Solution;

impl Solution {
    pub fn minimize_the_total_price(n: i32, edges: Vec<Vec<i32>>, price: Vec<i32>, trips: Vec<Vec<i32>>) -> i32 {
        let n = n as usize;
        let mut adj: Vec<Vec<usize>> = vec![vec![]; n];
        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            adj[u].push(v);
            adj[v].push(u);
        }

        let mut depth: Vec<i32> = vec![0; n];
        let mut parent: Vec<usize> = vec![0; n];

        Self::dfs_lca_setup(0, 0, 0, &adj, &mut depth, &mut parent);

        let get_lca = |mut u: usize, mut v: usize| -> usize {
            if depth[u] < depth[v] {
                std::mem::swap(&mut u, &mut v);
            }
            while depth[u] > depth[v] {
                u = parent[u];
            }

            if u == v {
                return u;
            }

            while parent[u] != parent[v] {
                u = parent[u];
                v = parent[v];
            }
            parent[u]
        };

        let mut node_trip_counts: Vec<i32> = vec![0; n];
        for trip in trips {
            let u = trip[0] as usize;
            let v = trip[1] as usize;

            node_trip_counts[u] += 1;
            node_trip_counts[v] += 1;

            let lca = get_lca(u, v);
            node_trip_counts[lca] -= 1;
            if lca != 0 {
                node_trip_counts[parent[lca]] -= 1;
            }
        }

        Self::dfs_sum_counts(0, 0, &adj, &mut node_trip_counts);

        let mut total_price_no_halving: i32 = 0;
        let mut max_saving: i32 = 0;

        for i in 0..n {
            let current_node_cost = node_trip_counts[i] * price[i];
            total_price_no_halving += current_node_cost;

            let saving_if_halved = node_trip_counts[i] * (price[i] / 2);
            max_saving = max(max_saving, saving_if_halved);
        }

        total_price_no_halving - max_saving
    }

    fn dfs_lca_setup(u: usize, p: usize, d: i32, adj: &Vec<Vec<usize>>, depth: &mut Vec<i32>, parent: &mut Vec<usize>) {
        depth[u] = d;
        parent[u] = p;
        for &v in &adj[u] {
            if v != p {
                Self::dfs_lca_setup(v, u, d + 1, adj, depth, parent);
            }
        }
    }

    fn dfs_sum_counts(u: usize, p: usize, adj: &Vec<Vec<usize>>, node_trip_counts: &mut Vec<i32>) {
        for &v in &adj[u] {
            if v != p {
                Self::dfs_sum_counts(v, u, adj, node_trip_counts);
                node_trip_counts[u] += node_trip_counts[v];
            }
        }
    }
}