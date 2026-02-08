use std::collections::HashSet;

impl Solution {
    pub fn max_output(n: i32, edges: Vec<Vec<i32>>, price: Vec<i32>) -> i64 {
        let n = n as usize;
        let mut adj = vec![HashSet::new(); n];
        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            adj[u].insert(v);
            adj[v].insert(u);
        }
        let mut res = 0;
        let mut max1 = vec![0; n];
        let mut max2 = vec![0; n];
        let mut min1 = vec![0; n];
        let mut min2 = vec![0; n];
        Self::dfs1(0, n, &adj, &price, &mut max1, &mut max2, &mut min1, &mut min2);
        Self::dfs2(0, n, &adj, &price, &mut max1, &mut max2, &mut min1, &mut min2, &mut res);
        res as i64
    }

    fn dfs1(
        u: usize,
        parent: usize,
        adj: &Vec<HashSet<usize>>,
        price: &Vec<i32>,
        max1: &mut Vec<i64>,
        max2: &mut Vec<i64>,
        min1: &mut Vec<i64>,
        min2: &mut Vec<i64>,
    ) {
        max1[u] = price[u] as i64;
        max2[u] = price[u] as i64;
        min1[u] = price[u] as i64;
        min2[u] = price[u] as i64;
        for &v in adj[u].iter() {
            if v == parent {
                continue;
            }
            Self::dfs1(v, u, adj, price, max1, max2, min1, min2);
            let current_max = max1[v] + price[u] as i64;
            if current_max > max1[u] {
                max2[u] = max1[u];
                max1[u] = current_max;
            } else if current_max > max2[u] {
                max2[u] = current_max;
            }
            let current_min = min1[v] + price[u] as i64;
            if current_min < min1[u] {
                min2[u] = min1[u];
                min1[u] = current_min;
            } else if current_min < min2[u] {
                min2[u] = current_min;
            }
        }
    }

    fn dfs2(
        u: usize,
        parent: usize,
        adj: &Vec<HashSet<usize>>,
        price: &Vec<i32>,
        max1: &mut Vec<i64>,
        max2: &mut Vec<i64>,
        min1: &mut Vec<i64>,
        min2: &mut Vec<i64>,
        res: &mut i64,
    ) {
        *res = (*res).max(max1[u] - min1[u]);
        for &v in adj[u].iter() {
            if v == parent {
                continue;
            }
            let original_max1_u = max1[u];
            let original_max2_u = max2[u];
            let original_min1_u = min1[u];
            let original_min2_u = min2[u];
            let current_max = max1[v] + price[u] as i64;
            let current_min = min1[v] + price[u] as i64;
            if current_max == max1[u] {
                max1[u] = max2[u];
            }
            if current_min == min1[u] {
                min1[u] = min2[u];
            }
            let new_max = max1[u] + price[v] as i64;
            if new_max > max1[v] {
                max2[v] = max1[v];
                max1[v] = new_max;
            } else if new_max > max2[v] {
                max2[v] = new_max;
            }
            let new_min = min1[u] + price[v] as i64;
            if new_min < min1[v] {
                min2[v] = min1[v];
                min1[v] = new_min;
            } else if new_min < min2[v] {
                min2[v] = new_min;
            }
            Self::dfs2(v, u, adj, price, max1, max2, min1, min2, res);
            max1[u] = original_max1_u;
            max2[u] = original_max2_u;
            min1[u] = original_min1_u;
            min2[u] = original_min2_u;
        }
    }
}