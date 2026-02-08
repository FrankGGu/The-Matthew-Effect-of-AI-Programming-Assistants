struct DSU {
    parent: Vec<i32>,
    size: Vec<i32>,
}

impl DSU {
    fn new(n: i32) -> Self {
        DSU {
            parent: (0..n).collect(),
            size: vec![1; n as usize],
        }
    }

    fn find(&mut self, i: i32) -> i32 {
        if self.parent[i as usize] == i {
            i
        } else {
            self.parent[i as usize] = self.find(self.parent[i as usize]);
            self.parent[i as usize]
        }
    }

    fn union(&mut self, i: i32, j: i32) -> bool {
        let mut root_i = self.find(i);
        let mut root_j = self.find(j);

        if root_i != root_j {
            if self.size[root_i as usize] < self.size[root_j as usize] {
                std::mem::swap(&mut root_i, &mut root_j);
            }
            self.parent[root_j as usize] = root_i;
            self.size[root_i as usize] += self.size[root_j as usize];
            true
        } else {
            false
        }
    }
}

impl Solution {
    pub fn friend_requests(n: i32, restrictions: Vec<Vec<i32>>, requests: Vec<Vec<i32>>) -> Vec<bool> {
        let mut dsu = DSU::new(n);
        let mut results = Vec::new();

        for request in requests {
            let p1 = request[0];
            let p2 = request[1];

            let root_p1 = dsu.find(p1);
            let root_p2 = dsu.find(p2);

            if root_p1 == root_p2 {
                results.push(true);
                continue;
            }

            let mut can_merge = true;
            for restriction in &restrictions {
                let r1 = restriction[0];
                let r2 = restriction[1];

                let root_r1 = dsu.find(r1);
                let root_r2 = dsu.find(r2);

                if (root_r1 == root_p1 && root_r2 == root_p2) ||
                   (root_r1 == root_p2 && root_r2 == root_p1) {
                    can_merge = false;
                    break;
                }
            }

            if can_merge {
                dsu.union(p1, p2);
                results.push(true);
            } else {
                results.push(false);
            }
        }

        results
    }
}