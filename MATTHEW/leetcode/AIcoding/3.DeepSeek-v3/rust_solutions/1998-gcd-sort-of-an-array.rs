struct UnionFind {
    parent: Vec<usize>,
    rank: Vec<usize>,
}

impl UnionFind {
    fn new(size: usize) -> Self {
        let parent = (0..size).collect();
        let rank = vec![0; size];
        UnionFind { parent, rank }
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
        if root_x == root_y {
            return;
        }
        if self.rank[root_x] < self.rank[root_y] {
            self.parent[root_x] = root_y;
        } else {
            self.parent[root_y] = root_x;
            if self.rank[root_x] == self.rank[root_y] {
                self.rank[root_x] += 1;
            }
        }
    }
}

impl Solution {
    pub fn gcd_sort(nums: Vec<i32>) -> bool {
        let max_num = *nums.iter().max().unwrap() as usize;
        let mut sieve = vec![0; max_num + 1];
        for i in 2..=max_num {
            if sieve[i] == 0 {
                sieve[i] = i;
                let mut j = i * 2;
                while j <= max_num {
                    if sieve[j] == 0 {
                        sieve[j] = i;
                    }
                    j += i;
                }
            }
        }

        let mut uf = UnionFind::new(max_num + 1);
        for &num in &nums {
            let mut x = num as usize;
            let mut factors = Vec::new();
            while x > 1 {
                let p = sieve[x];
                factors.push(p);
                x /= p;
            }
            for i in 1..factors.len() {
                uf.union(factors[i - 1], factors[i]);
            }
        }

        let mut sorted_nums = nums.clone();
        sorted_nums.sort();
        for i in 0..nums.len() {
            let original = nums[i] as usize;
            let target = sorted_nums[i] as usize;
            if original == target {
                continue;
            }
            if sieve[original] == 0 || sieve[target] == 0 {
                return false;
            }
            if uf.find(sieve[original]) != uf.find(sieve[target]) {
                return false;
            }
        }
        true
    }
}