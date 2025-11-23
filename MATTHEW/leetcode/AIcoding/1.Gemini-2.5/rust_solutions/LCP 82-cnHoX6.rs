use std::collections::HashMap;

struct Solution;

impl Solution {
    pub fn tree_of_all_spirits(n: i32, parent: Vec<i32>, values: Vec<i32>) -> i32 {
        let n = n as usize;
        let mut adj: Vec<Vec<usize>> = vec![vec![]; n];

        for i in 0..n - 1 {
            let u = parent[i] as usize;
            let v = i + 1;
            adj[u].push(v);
        }

        let mut memo: Vec<Option<HashMap<i32, i32>>> = vec![None; n];

        fn dfs(
            u: usize,
            adj: &Vec<Vec<usize>>,
            values: &Vec<i32>,
            memo: &mut Vec<Option<HashMap<i32, i32>>>,
        ) -> HashMap<i32, i32> {
            if let Some(cached_map) = memo[u].take() {
                return cached_map;
            }

            let mut map_u: HashMap<i32, i32> = HashMap::new();
            map_u.insert(values[u], 0);

            for &v in adj[u].iter() {
                let map_v = dfs(v, adj, values, memo);

                let (mut current_map, mut child_map) = if map_u.len() < map_v.len() {
                    (map_v, map_u)
                } else {
                    (map_u, map_v)
                };

                let mut merged_map = HashMap::new();

                for (val_key, cost_current) in current_map.drain() {
                    let cost_child = *child_map.get(&val_key).unwrap_or(&i32::MAX);

                    let new_cost;
                    if cost_child == i32::MAX {
                        new_cost = cost_current + 1;
                    } else {
                        new_cost = cost_current + cost_child;
                    }
                    merged_map.insert(val_key, new_cost);
                }

                for (val_key, cost_child) in child_map.drain() {
                    if !merged_map.contains_key(&val_key) {
                        merged_map.insert(val_key, cost_child + 1);
                    }
                }
                map_u = merged_map;
            }

            for (_, cost) in map_u.iter_mut() {
                *cost = (*cost).min(1);
            }

            let result_map = map_u;
            memo[u] = Some(result_map.clone());
            result_map
        }

        let final_map = dfs(0, &adj, &values, &mut memo);

        *final_map.values().min().unwrap_or(&0)
    }
}