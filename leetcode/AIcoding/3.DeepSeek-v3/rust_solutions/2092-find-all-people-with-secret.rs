use std::collections::{BinaryHeap, HashMap, HashSet};

struct UnionFind {
    parent: Vec<usize>,
    rank: Vec<usize>,
}

impl UnionFind {
    fn new(n: usize) -> Self {
        let parent = (0..n).collect();
        let rank = vec![0; n];
        UnionFind { parent, rank }
    }

    fn find(&mut self, x: usize) -> usize {
        if self.parent[x] != x {
            self.parent[x] = self.find(self.parent[x]);
        }
        self.parent[x]
    }

    fn union(&mut self, x: usize, y: usize) {
        let x_root = self.find(x);
        let y_root = self.find(y);
        if x_root == y_root {
            return;
        }
        if self.rank[x_root] < self.rank[y_root] {
            self.parent[x_root] = y_root;
        } else {
            self.parent[y_root] = x_root;
            if self.rank[x_root] == self.rank[y_root] {
                self.rank[x_root] += 1;
            }
        }
    }
}

impl Solution {
    pub fn find_all_people(n: i32, meetings: Vec<Vec<i32>>, first_person: i32) -> Vec<i32> {
        let n = n as usize;
        let mut time_map: HashMap<i32, Vec<(usize, usize)>> = HashMap::new();
        for meeting in meetings {
            let x = meeting[0] as usize;
            let y = meeting[1] as usize;
            let t = meeting[2];
            time_map.entry(t).or_default().push((x, y));
        }
        let mut times: Vec<i32> = time_map.keys().cloned().collect();
        times.sort_unstable();

        let mut uf = UnionFind::new(n);
        uf.union(0, first_person as usize);

        for t in times {
            let mut people = HashSet::new();
            for &(x, y) in &time_map[&t] {
                uf.union(x, y);
                people.insert(x);
                people.insert(y);
            }
            let root = uf.find(0);
            for &p in &people {
                if uf.find(p) != root {
                    uf.parent[p] = p;
                }
            }
        }

        let root = uf.find(0);
        (0..n as i32).filter(|&i| uf.find(i as usize) == root).collect()
    }
}