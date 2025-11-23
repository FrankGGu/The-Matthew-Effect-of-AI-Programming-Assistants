struct DSU {
    parent: Vec<usize>,
    size: Vec<usize>,
}

impl DSU {
    fn new(n: usize) -> Self {
        let mut parent = vec![0; n];
        let mut size = vec![1; n];
        for i in 0..n {
            parent[i] = i;
        }
        DSU { parent, size }
    }

    fn find(&mut self, x: usize) -> usize {
        if self.parent[x] != x {
            self.parent[x] = self.find(self.parent[x]);
        }
        self.parent[x]
    }

    fn union(&mut self, x: usize, y: usize) {
        let root_x = self.find(x);
        let root_y = self.find(y);
        if root_x != root_y {
            if self.size[root_x] < self.size[root_y] {
                self.parent[root_x] = root_y;
                self.size[root_y] += self.size[root_x];
            } else {
                self.parent[root_y] = root_x;
                self.size[root_x] += self.size[root_y];
            }
        }
    }
}

impl Solution {
    pub fn number_of_good_paths(vals: Vec<i32>, edges: Vec<Vec<i32>>) -> i32 {
        let n = vals.len();
        let mut adj: Vec<Vec<usize>> = vec![vec![]; n];
        for edge in &edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            adj[u].push(v);
            adj[v].push(u);
        }

        let mut nodes: Vec<usize> = (0..n).collect();
        nodes.sort_by_key(|&i| vals[i] as i32);

        let mut dsu = DSU::new(n);
        let mut count = 0;

        for &node in &nodes {
            for &neighbor in &adj[node] {
                if vals[neighbor] <= vals[node] {
                    dsu.union(node, neighbor);
                }
            }

            let mut group_counts: std::collections::HashMap<usize, i32> = std::collections::HashMap::new();
            for &neighbor in &adj[node] {
                if vals[neighbor] == vals[node] {
                    let root = dsu.find(neighbor);
                    *group_counts.entry(root).or_insert(0) += 1;
                }
            }

            count += 1; // Each node is a good path of length 1
            for (_, c) in group_counts {
                count += c + 1;
                count -= 1;
            }
        }

        count as i32
    }
}