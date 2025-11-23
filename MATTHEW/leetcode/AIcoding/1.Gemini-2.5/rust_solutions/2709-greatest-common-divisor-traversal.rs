struct DSU {
    parent: Vec<usize>,
}

impl DSU {
    fn new(n: usize) -> Self {
        DSU {
            parent: (0..n).collect(),
        }
    }

    fn find(&mut self, i: usize) -> usize {
        if self.parent[i] == i {
            i
        } else {
            self.parent[i] = self.find(self.parent[i]);
            self.parent[i]
        }
    }

    fn union(&mut self, i: usize, j: usize) -> bool {
        let root_i = self.find(i);
        let root_j = self.find(j);
        if root_i != root_j {
            self.parent[root_i] = root_j;
            true
        } else {
            false
        }
    }
}

impl Solution {
    pub fn can_traverse_all_pairs(nums: Vec<i32>) -> bool {
        let n = nums.len();
        if n <= 1 {
            return true;
        }

        let max_val = *nums.iter().max().unwrap();

        if nums.iter().any(|&x| x == 1) {
            return false;
        }

        let mut spf = vec![0; max_val as usize + 1];
        for i in 2..=(max_val as usize) {
            spf[i] = i;
        }
        for i in 2..=(max_val as usize) {
            if spf[i] == i {
                let mut j = i * i;
                while j <= (max_val as usize) {
                    if spf[j] == j {
                        spf[j] = i;
                    }
                    j += i;
                }
            }
        }

        let mut dsu = DSU::new(n + max_val as usize + 1);

        for i in 0..n {
            let mut num = nums[i];
            while num > 1 {
                let p = spf[num as usize];
                dsu.union(i, n + p);
                while num > 1 && num % p == 0 {
                    num /= p;
                }
            }
        }

        let first_root = dsu.find(0);
        for i in 1..n {
            if dsu.find(i) != first_root {
                return false;
            }
        }

        true
    }
}