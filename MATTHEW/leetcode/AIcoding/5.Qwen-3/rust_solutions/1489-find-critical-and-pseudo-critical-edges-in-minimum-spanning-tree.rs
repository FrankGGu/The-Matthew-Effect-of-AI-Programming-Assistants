impl Solution {

use std::collections::HashSet;

struct UnionFind {
    parent: Vec<usize>,
    rank: Vec<usize>,
}

impl UnionFind {
    fn new(n: usize) -> Self {
        UnionFind {
            parent: (0..n).collect(),
            rank: vec![1; n],
        }
    }

    fn find(&mut self, x: usize) -> usize {
        if self.parent[x] != x {
            self.parent[x] = self.find(self.parent[x]);
        }
        self.parent[x]
    }

    fn union(&mut self, x: usize, y: usize) -> bool {
        let root_x = self.find(x);
        let root_y = self.find(y);
        if root_x == root_y {
            return false;
        }
        if self.rank[root_x] < self.rank[root_y] {
            self.parent[root_x] = root_y;
        } else {
            self.parent[root_y] = root_x;
            if self.rank[root_x] == self.rank[root_y] {
                self.rank[root_x] += 1;
            }
        }
        true
    }
}

fn kruskal(n: usize, edges: &Vec<(usize, usize, usize)>, include_edge: Option<(usize, usize, usize)>, exclude_edge: Option<(usize, usize, usize)>) -> (usize, bool) {
    let mut sorted_edges = edges.clone();
    sorted_edges.sort_by_key(|e| e.2);

    let mut uf = UnionFind::new(n);
    let mut total_weight = 0;
    let mut edge_count = 0;

    if let Some((u, v, w)) = include_edge {
        if uf.union(u, v) {
            total_weight += w;
            edge_count += 1;
        }
    }

    for &(u, v, w) in &sorted_edges {
        if let Some((eu, ev, ew)) = exclude_edge {
            if (u == eu && v == ev && w == ew) || (u == ev && v == eu && w == ew) {
                continue;
            }
        }
        if uf.union(u, v) {
            total_weight += w;
            edge_count += 1;
        }
    }

    if edge_count == n - 1 {
        (total_weight, true)
    } else {
        (0, false)
    }
}

pub fn find_critical_and_pseudo_critical_edges(n: i32, edges: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
    let n = n as usize;
    let m = edges.len();
    let mut original_edges: Vec<(usize, usize, usize)> = edges.into_iter()
        .map(|e| (e[0] as usize, e[1] as usize, e[2] as usize))
        .collect();

    let (min_weight, _) = kruskal(n, &original_edges, None, None);

    let mut critical = HashSet::new();
    let mut pseudo_critical = HashSet::new();

    for i in 0..m {
        let (u, v, w) = original_edges[i];
        let (_, ok) = kruskal(n, &original_edges, None, Some((u, v, w)));
        if !ok {
            critical.insert(i);
        } else {
            let (w2, ok2) = kruskal(n, &original_edges, Some((u, v, w)), None);
            if ok2 && w2 == min_weight {
                pseudo_critical.insert(i);
            }
        }
    }

    let mut result = Vec::new();
    for i in 0..m {
        if critical.contains(&i) {
            result.push(vec![i as i32, 0]);
        } else if pseudo_critical.contains(&i) {
            result.push(vec![i as i32, 1]);
        }
    }

    result
}
}