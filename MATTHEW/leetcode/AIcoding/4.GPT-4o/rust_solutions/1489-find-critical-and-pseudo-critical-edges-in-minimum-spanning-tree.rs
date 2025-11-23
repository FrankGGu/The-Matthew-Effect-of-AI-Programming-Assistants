pub fn find_critical_and_pseudo_critical_edges(n: i32, edges: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
    let mut edges_with_index: Vec<(i32, i32, i32, usize)> = edges
        .into_iter()
        .enumerate()
        .map(|(i, e)| (e[0], e[1], e[2], i))
        .collect();

    edges_with_index.sort_by_key(|e| e.2);

    fn find(parent: &mut Vec<i32>, x: i32) -> i32 {
        if parent[x as usize] != x {
            parent[x as usize] = find(parent, parent[x as usize]);
        }
        parent[x as usize]
    }

    fn union(parent: &mut Vec<i32>, rank: &mut Vec<i32>, x: i32, y: i32) -> bool {
        let root_x = find(parent, x);
        let root_y = find(parent, y);
        if root_x == root_y {
            return false;
        }
        if rank[root_x as usize] > rank[root_y as usize] {
            parent[root_y as usize] = root_x;
        } else if rank[root_x as usize] < rank[root_y as usize] {
            parent[root_x as usize] = root_y;
        } else {
            parent[root_y as usize] = root_x;
            rank[root_x as usize] += 1;
        }
        true
    }

    fn kruskal(n: i32, edges: &[(i32, i32, i32, usize)], exclude: Option<usize>, include: Option<usize>) -> (i32, Vec<i32>) {
        let mut parent: Vec<i32> = (0..n).collect();
        let mut rank: Vec<i32> = vec![0; n as usize];
        let mut total_weight = 0;
        let mut count = 0;
        let mut included_edges = vec![];

        if let Some(include_index) = include {
            let (u, v, w, _) = edges[include_index];
            total_weight += w;
            count += 1;
            union(&mut parent, &mut rank, u, v);
            included_edges.push(include_index as i32);
        }

        for (i, &(u, v, w, index)) in edges.iter().enumerate() {
            if Some(i) == exclude {
                continue;
            }
            if union(&mut parent, &mut rank, u, v) {
                total_weight += w;
                count += 1;
                included_edges.push(index as i32);
            }
        }

        if count == n - 1 {
            (total_weight, included_edges)
        } else {
            (i32::MAX, vec![])
        }
    }

    let (mst_weight, mst_edges) = kruskal(n, &edges_with_index, None, None);
    let mut critical_edges = vec![];
    let mut pseudo_critical_edges = vec![];

    for i in 0..edges_with_index.len() {
        if kruskal(n, &edges_with_index, Some(i), None).0 > mst_weight {
            critical_edges.push(edges_with_index[i].3 as i32);
        } else if kruskal(n, &edges_with_index, None, Some(i)).0 == mst_weight {
            pseudo_critical_edges.push(edges_with_index[i].3 as i32);
        }
    }

    vec![critical_edges, pseudo_critical_edges]
}