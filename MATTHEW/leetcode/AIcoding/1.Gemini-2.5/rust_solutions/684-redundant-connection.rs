impl Solution {
    pub fn find_redundant_connection(edges: Vec<Vec<i32>>) -> Vec<i32> {
        let n = edges.len();
        let mut parent: Vec<usize> = (0..=n).collect();

        fn find(mut i: usize, parent: &mut Vec<usize>) -> usize {
            if parent[i] == i {
                return i;
            }
            parent[i] = find(parent[i], parent);
            parent[i]
        }

        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;

            let root_u = find(u, &mut parent);
            let root_v = find(v, &mut parent);

            if root_u == root_v {
                return edge;
            } else {
                parent[root_v] = root_u;
            }
        }
        unreachable!()
    }
}