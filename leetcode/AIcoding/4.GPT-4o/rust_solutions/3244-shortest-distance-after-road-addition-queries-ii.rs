use std::collections::HashMap;

struct UnionFind {
    parent: Vec<usize>,
    rank: Vec<usize>,
    size: Vec<usize>,
}

impl UnionFind {
    fn new(n: usize) -> Self {
        let mut parent = Vec::with_capacity(n);
        let mut rank = vec![1; n];
        let mut size = vec![1; n];
        for i in 0..n {
            parent.push(i);
        }
        UnionFind { parent, rank, size }
    }

    fn find(&mut self, u: usize) -> usize {
        if self.parent[u] != u {
            self.parent[u] = self.find(self.parent[u]);
        }
        self.parent[u]
    }

    fn union(&mut self, u: usize, v: usize) {
        let pu = self.find(u);
        let pv = self.find(v);
        if pu != pv {
            if self.rank[pu] > self.rank[pv] {
                self.parent[pv] = pu;
                self.size[pu] += self.size[pv];
            } else if self.rank[pu] < self.rank[pv] {
                self.parent[pu] = pv;
                self.size[pv] += self.size[pu];
            } else {
                self.parent[pv] = pu;
                self.size[pu] += self.size[pv];
                self.rank[pu] += 1;
            }
        }
    }

    fn get_size(&mut self, u: usize) -> usize {
        let pu = self.find(u);
        self.size[pu]
    }
}

pub fn shortest_distance(n: i32, roads: Vec<Vec<i32>>, queries: Vec<Vec<i32>>) -> Vec<i32> {
    let mut union_find = UnionFind::new(n as usize);
    let mut distance_map: HashMap<(usize, usize), i32> = HashMap::new();

    for road in roads {
        let u = road[0] as usize;
        let v = road[1] as usize;
        let w = road[2];
        union_find.union(u, v);
        let dist = distance_map.entry((u, v)).or_insert(i32::MAX);
        *dist = (*dist).min(w);
        distance_map.entry((v, u)).or_insert(i32::MAX);
    }

    let mut result = Vec::new();

    for query in queries {
        let u = query[0] as usize;
        let v = query[1] as usize;
        let new_road = query[2];
        union_find.union(u, v);
        let size_u = union_find.get_size(u);
        let size_v = union_find.get_size(v);
        let total_size = size_u + size_v - 1;
        let distance = distance_map.get(&(u, v)).cloned().unwrap_or(i32::MAX);
        result.push(if distance == i32::MAX { -1 } else { distance + new_road });
    }

    result
}