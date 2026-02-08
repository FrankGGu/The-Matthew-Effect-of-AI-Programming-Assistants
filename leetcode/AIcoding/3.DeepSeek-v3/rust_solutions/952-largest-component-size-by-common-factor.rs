use std::collections::HashMap;

struct UnionFind {
    parent: Vec<usize>,
    size: Vec<usize>,
}

impl UnionFind {
    fn new(n: usize) -> Self {
        let parent = (0..n).collect();
        let size = vec![1; n];
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
        if nums.is_empty() {
            return 0;
        }
        let max_num = *nums.iter().max().unwrap() as usize;
        let mut uf = UnionFind::new(max_num + 1);
        let mut factor_to_num = HashMap::new();

        for &num in &nums {
            let factors = Self::get_prime_factors(num as usize);
            for &factor in &factors {
                factor_to_num.entry(factor).or_insert(num as usize);
                uf.union(num as usize, factor_to_num[&factor]);
            }
        }

        let mut root_counts = HashMap::new();
        let mut max_size = 0;
        for &num in &nums {
            let root = uf.find(num as usize);
            let count = root_counts.entry(root).or_insert(0);
            *count += 1;
            if *count > max_size {
                max_size = *count;
            }
        }
        max_size
    }

    fn get_prime_factors(mut n: usize) -> Vec<usize> {
        let mut factors = Vec::new();
        if n < 2 {
            return factors;
        }
        let mut i = 2;
        while i * i <= n {
            if n % i == 0 {
                factors.push(i);
                while n % i == 0 {
                    n /= i;
                }
            }
            i += 1;
        }
        if n > 1 {
            factors.push(n);
        }
        factors
    }
}