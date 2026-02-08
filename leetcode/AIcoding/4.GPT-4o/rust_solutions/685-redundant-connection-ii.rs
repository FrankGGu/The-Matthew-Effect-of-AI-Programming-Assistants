pub struct UnionFind {
    parent: Vec<i32>,
    rank: Vec<i32>,
}

impl UnionFind {
    fn new(n: usize) -> Self {
        UnionFind {
            parent: (0..n as i32).collect(),
            rank: vec![1; n],
        }
    }

    fn find(&mut self, x: i32) -> i32 {
        if self.parent[x as usize] != x {
            self.parent[x as usize] = self.find(self.parent[x as usize]);
        }
        self.parent[x as usize]
    }

    fn union(&mut self, x: i32, y: i32) -> bool {
        let root_x = self.find(x);
        let root_y = self.find(y);
        if root_x == root_y {
            return false;
        }
        if self.rank[root_x as usize] < self.rank[root_y as usize] {
            self.parent[root_x as usize] = root_y;
        } else if self.rank[root_x as usize] > self.rank[root_y as usize] {
            self.parent[root_y as usize] = root_x;
        } else {
            self.parent[root_y as usize] = root_x;
            self.rank[root_x as usize] += 1;
        }
        true
    }
}

pub fn find_redundant_directed_connection(edges: Vec<Vec<i32>>) -> Vec<i32> {
    let n = edges.len();
    let mut uf = UnionFind::new(n + 1);
    let mut parent = vec![0; n + 1];
    let mut candidates = vec![];

    for edge in &edges {
        let (u, v) = (edge[0], edge[1]);
        if parent[v as usize] != 0 {
            candidates.push(vec![parent[v as usize], v]);
            candidates.push(vec![u, v]);
        } else {
            parent[v as usize] = u;
            if !uf.union(u, v) {
                candidates.push(vec![u, v]);
            }
        }
    }

    if candidates.is_empty() {
        return vec![];
    }

    if candidates.len() == 1 {
        return candidates[0].clone();
    }

    let (u, v) = (candidates[1][0], candidates[1][1]);
    let mut uf = UnionFind::new(n + 1);
    for edge in &edges {
        if edge == &candidates[1] {
            continue;
        }
        uf.union(edge[0], edge[1]);
    }

    if uf.find(u) == uf.find(v) {
        return candidates[1].clone();
    }
    candidates[0].clone()
}