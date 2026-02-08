impl Solution {
    pub fn find_redundant_directed_connection(edges: Vec<Vec<i32>>) -> Vec<i32> {
        let n = edges.len();
        let mut parents = vec![0; n + 1];
        let mut in_degree = vec![0; n + 1];
        let mut two_parents = -1;
        for i in 0..n {
            let u = edges[i][0] as usize;
            let v = edges[i][1] as usize;
            in_degree[v] += 1;
            if in_degree[v] == 2 {
                two_parents = i as i32;
            }
        }

        let mut uf = UnionFind::new(n);
        let mut cycle_edge = -1;
        let mut result = vec![0, 0];

        for i in 0..n {
            if i as i32 == two_parents {
                continue;
            }
            let u = edges[i][0] as usize;
            let v = edges[i][1] as usize;
            if uf.union(u, v) == false {
                cycle_edge = i as i32;
            }
        }

        if two_parents == -1 {
            result[0] = edges[cycle_edge as usize][0];
            result[1] = edges[cycle_edge as usize][1];
            return result;
        }

        uf = UnionFind::new(n);
        for i in 0..n {
            if i as i32 == two_parents {
                continue;
            }
            let u = edges[i][0] as usize;
            let v = edges[i][1] as usize;
            uf.union(u, v);
        }

        let u = edges[two_parents as usize][0];
        let v = edges[two_parents as usize][1];

        if uf.union(u as usize, v as usize) == false {
            for i in 0..n {
                if edges[i][1] == v {
                    result[0] = edges[i][0];
                    result[1] = edges[i][1];
                    if i as i32 != two_parents {
                        return result;
                    }
                    break;
                }
            }
            return result;
        }
        result[0] = u;
        result[1] = v;
        return result;
    }
}

struct UnionFind {
    parent: Vec<usize>,
}

impl UnionFind {
    fn new(n: usize) -> Self {
        let mut parent = vec![0; n + 1];
        for i in 1..=n {
            parent[i] = i;
        }
        UnionFind { parent }
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