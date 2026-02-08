struct UnionFind {
    parent: Vec<usize>,
    size: Vec<usize>,
}

impl UnionFind {
    fn new(n: usize) -> Self {
        let mut parent = vec![0; n];
        let mut size = vec![1; n];
        for i in 0..n {
            parent[i] = i;
        }
        UnionFind { parent, size }
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
    pub fn largest_component_size(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let max_num = *nums.iter().max().unwrap() as usize;
        let mut uf = UnionFind::new(max_num + 1);

        for &num in &nums {
            let num = num as usize;
            let mut i = 2;
            let mut temp = num;
            while i * i <= temp {
                if temp % i == 0 {
                    uf.union(num, i);
                    while temp % i == 0 {
                        temp /= i;
                    }
                }
                i += 1;
            }
            if temp > 1 {
                uf.union(num, temp);
            }
        }

        let mut counts = std::collections::HashMap::new();
        for &num in &nums {
            let root = uf.find(num as usize);
            *counts.entry(root).or_insert(0) += 1;
        }

        *counts.values().max().unwrap_or(&0) as i32
    }
}