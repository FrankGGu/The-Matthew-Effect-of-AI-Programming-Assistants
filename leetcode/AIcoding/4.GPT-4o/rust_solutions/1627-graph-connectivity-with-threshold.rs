pub fn are_connected(n: i32, threshold: i32, queries: Vec<Vec<i32>>) -> Vec<bool> {
    use std::collections::HashSet;

    let mut parent = (0..=n).collect::<Vec<_>>();
    let mut rank = vec![0; n as usize + 1];

    fn find(x: usize, parent: &mut Vec<usize>) -> usize {
        if parent[x] != x {
            parent[x] = find(parent[x], parent);
        }
        parent[x]
    }

    fn union(x: usize, y: usize, parent: &mut Vec<usize>, rank: &mut Vec<i32>) {
        let root_x = find(x, parent);
        let root_y = find(y, parent);
        if root_x != root_y {
            if rank[root_x] > rank[root_y] {
                parent[root_y] = root_x;
            } else if rank[root_x] < rank[root_y] {
                parent[root_x] = root_y;
            } else {
                parent[root_y] = root_x;
                rank[root_x] += 1;
            }
        }
    }

    if threshold == 0 {
        return queries.iter().map(|q| q[0] == q[1]).collect();
    }

    for i in (threshold + 1)..=n {
        for j in (i + i..=n).step_by(i as usize) {
            union(i as usize, j as usize, &mut parent, &mut rank);
        }
    }

    queries.iter()
        .map(|q| find(q[0] as usize, &mut parent) == find(q[1] as usize, &mut parent))
        .collect()
}