use std::collections::HashSet;

impl Solution {
    pub fn max_sum_edge_value(n: i32, edges: Vec<Vec<i32>>) -> i32 {
        let n = n as usize;
        let mut parent = (0..n).collect::<Vec<_>>();
        let mut rank = vec![0; n];

        fn find(parent: &mut Vec<usize>, u: usize) -> usize {
            if parent[u] != u {
                parent[u] = find(parent, parent[u]);
            }
            parent[u]
        }

        fn union(parent: &mut Vec<usize>, rank: &mut Vec<i32>, u: usize, v: usize) {
            let root_u = find(parent, u);
            let root_v = find(parent, v);
            if root_u != root_v {
                if rank[root_u] > rank[root_v] {
                    parent[root_v] = root_u;
                } else if rank[root_u] < rank[root_v] {
                    parent[root_u] = root_v;
                } else {
                    parent[root_v] = root_u;
                    rank[root_u] += 1;
                }
            }
        }

        let mut sorted_edges = edges;
        sorted_edges.sort_unstable_by(|a, b| b[2].cmp(&a[2]));

        let mut mst_edges = HashSet::new();
        for edge in &sorted_edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            if find(&mut parent, u) != find(&mut parent, v) {
                union(&mut parent, &mut rank, u, v);
                mst_edges.insert((u, v, edge[2]));
            }
        }

        let mut max_sum = 0;
        for edge in &edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            let value = edge[2];
            if mst_edges.contains(&(u, v, value)) || mst_edges.contains(&(v, u, value)) {
                max_sum += value;
            }
        }

        max_sum
    }
}