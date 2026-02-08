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
    pub fn can_traverse_all_pairs(nums: Vec<i32>) -> bool {
        let n = nums.len();
        if n == 1 {
            return true;
        }

        let mut dsu = DSU::new(n);
        let max_val = *nums.iter().max().unwrap() as usize;
        let mut factors: Vec<Vec<usize>> = vec![Vec::new(); max_val + 1];

        for i in 0..n {
            let mut num = nums[i] as usize;
            for j in 2..=(num as f64).sqrt() as usize {
                if num % j == 0 {
                    factors[j].push(i);
                    while num % j == 0 {
                        num /= j;
                    }
                }
            }
            if num > 1 {
                factors[num].push(i);
            }
        }

        for i in 2..=max_val {
            if !factors[i].is_empty() {
                for j in 1..factors[i].len() {
                    dsu.union(factors[i][0], factors[i][j]);
                }
            }
        }

        let mut components = 0;
        let mut first_root = None;
        for i in 0..n {
            let root = dsu.find(i);
            if first_root.is_none() {
                first_root = Some(root);
                components += 1;
            } else if first_root.unwrap() != root {
                components += 1;
                break;
            }
        }

        components == 1
    }
}