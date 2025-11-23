pub fn max_num_edges_to_remove(n: i32, edges: Vec<Vec<i32>>) -> i32 {
    use std::collections::HashSet;

    let mut parent_a = (0..n).collect::<Vec<_>>();
    let mut parent_b = (0..n).collect::<Vec<_>>();

    fn find(parent: &mut Vec<i32>, x: i32) -> i32 {
        if parent[x as usize] != x {
            parent[x as usize] = find(parent, parent[x as usize]);
        }
        parent[x as usize]
    }

    fn union(parent: &mut Vec<i32>, x: i32, y: i32) -> bool {
        let root_x = find(parent, x);
        let root_y = find(parent, y);
        if root_x == root_y {
            return false;
        }
        parent[root_y as usize] = root_x;
        true
    }

    let mut total_edges = 0;
    let mut removed_edges = 0;

    for edge in &edges {
        if edge[0] == 3 {
            if union(&mut parent_a, edge[1] - 1, edge[2] - 1) {
                total_edges += 1;
            } else {
                removed_edges += 1;
            }
        }
    }

    let initial_a = (0..n).collect::<HashSet<_>>().len();
    for i in 0..n {
        find(&mut parent_a, i);
    }

    if parent_a.iter().collect::<HashSet<_>>().len() > 1 {
        return 0;
    }

    parent_b = (0..n).collect::<Vec<_>>();

    for edge in &edges {
        if edge[0] == 1 {
            if union(&mut parent_b, edge[1] - 1, edge[2] - 1) {
                total_edges += 1;
            } else {
                removed_edges += 1;
            }
        }
    }

    for i in 0..n {
        find(&mut parent_b, i);
    }

    if parent_b.iter().collect::<HashSet<_>>().len() > 1 {
        return 0;
    }

    for edge in &edges {
        if edge[0] == 2 {
            if union(&mut parent_b, edge[1] - 1, edge[2] - 1) {
                total_edges += 1;
            } else {
                removed_edges += 1;
            }
        }
    }

    if parent_b.iter().collect::<HashSet<_>>().len() > 1 {
        return 0;
    }

    (edges.len() as i32 - total_edges as i32) - removed_edges as i32
}