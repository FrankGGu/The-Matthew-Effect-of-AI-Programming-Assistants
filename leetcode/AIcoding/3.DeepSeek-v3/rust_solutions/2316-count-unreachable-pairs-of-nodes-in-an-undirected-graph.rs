impl Solution {
    pub fn count_pairs(n: i32, edges: Vec<Vec<i32>>) -> i64 {
        let n = n as usize;
        let mut parent = vec![0; n];
        let mut size = vec![1; n];
        for i in 0..n {
            parent[i] = i;
        }

        fn find(u: usize, parent: &mut Vec<usize>) -> usize {
            if parent[u] != u {
                parent[u] = find(parent[u], parent);
            }
            parent[u]
        }

        fn union(u: usize, v: usize, parent: &mut Vec<usize>, size: &mut Vec<usize>) {
            let root_u = find(u, parent);
            let root_v = find(v, parent);
            if root_u != root_v {
                if size[root_u] < size[root_v] {
                    parent[root_u] = root_v;
                    size[root_v] += size[root_u];
                } else {
                    parent[root_v] = root_u;
                    size[root_u] += size[root_v];
                }
            }
        }

        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            union(u, v, &mut parent, &mut size);
        }

        let mut component_sizes = Vec::new();
        let mut visited = vec![false; n];
        for i in 0..n {
            let root = find(i, &mut parent);
            if !visited[root] {
                visited[root] = true;
                component_sizes.push(size[root] as i64);
            }
        }

        let total_nodes: i64 = n as i64;
        let mut total_pairs = 0;
        let mut sum = 0;
        for &s in &component_sizes {
            total_pairs += sum * s;
            sum += s;
        }

        total_pairs
    }
}