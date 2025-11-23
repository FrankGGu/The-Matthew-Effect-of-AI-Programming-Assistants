pub struct UnionFind {
    parent: Vec<usize>,
    rank: Vec<usize>,
}

impl UnionFind {
    pub fn new(n: usize) -> Self {
        let parent = (0..n).collect();
        let rank = vec![1; n];
        UnionFind { parent, rank }
    }

    pub fn find(&mut self, x: usize) -> usize {
        if self.parent[x] != x {
            self.parent[x] = self.find(self.parent[x]);
        }
        self.parent[x]
    }

    pub fn union(&mut self, x: usize, y: usize) {
        let root_x = self.find(x);
        let root_y = self.find(y);
        if root_x != root_y {
            if self.rank[root_x] > self.rank[root_y] {
                self.parent[root_y] = root_x;
            } else if self.rank[root_x] < self.rank[root_y] {
                self.parent[root_x] = root_y;
            } else {
                self.parent[root_y] = root_x;
                self.rank[root_x] += 1;
            }
        }
    }
}

impl Solution {
    pub fn distance_to_cycle(n: i32, edges: Vec<Vec<i32>>, queries: Vec<Vec<i32>>) -> Vec<i32> {
        let mut uf = UnionFind::new(n as usize);
        let mut graph = vec![vec![]; n as usize];
        for edge in edges.iter() {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            uf.union(u, v);
            graph[u].push(v);
            graph[v].push(u);
        }

        let mut distances = vec![-1; n as usize];
        for i in 0..n as usize {
            if distances[i] == -1 {
                let mut stack = vec![i];
                let mut dist = 0;
                let mut visited = vec![false; n as usize];
                while let Some(node) = stack.pop() {
                    if visited[node] {
                        continue;
                    }
                    visited[node] = true;
                    distances[node] = dist;
                    dist += 1;
                    for &neigh in &graph[node] {
                        if !visited[neigh] {
                            stack.push(neigh);
                        }
                    }
                }
            }
        }

        let mut result = Vec::new();
        for query in queries.iter() {
            let u = query[0] as usize;
            let v = query[1] as usize;
            if uf.find(u) != uf.find(v) {
                result.push(-1);
            } else {
                result.push(distances[u] + distances[v]);
            }
        }
        result
    }
}