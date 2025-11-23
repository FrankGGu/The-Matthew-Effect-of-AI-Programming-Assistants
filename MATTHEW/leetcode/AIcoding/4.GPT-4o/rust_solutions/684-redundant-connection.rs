pub fn find_redundant_directed_connection(edges: Vec<Vec<i32>>) -> Vec<i32> {
    let mut parent = vec![0; edges.len() + 1];
    let mut indegree = vec![0; edges.len() + 1];
    let mut edge_to_remove = vec![-1, -1];

    for edge in &edges {
        indegree[edge[1] as usize] += 1;
    }

    for edge in &edges {
        if indegree[edge[1] as usize] == 2 {
            edge_to_remove = edge.clone();
            break;
        }
    }

    let mut uf = UnionFind::new(edges.len() + 1);

    for edge in &edges {
        if edge == &edge_to_remove {
            continue;
        }
        if !uf.union(edge[0] as usize, edge[1] as usize) {
            return edge.clone();
        }
    }

    edge_to_remove
}

struct UnionFind {
    parent: Vec<usize>,
}

impl UnionFind {
    fn new(size: usize) -> Self {
        Self {
            parent: (0..size).collect(),
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
        self.parent[root_x] = root_y;
        true
    }
}