impl Solution {

use std::collections::{HashMap, HashSet};

struct UnionFind {
    parent: Vec<usize>,
}

impl UnionFind {
    fn new(n: usize) -> Self {
        Self {
            parent: (0..n).collect(),
        }
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
            self.parent[root_y] = root_x;
        }
    }
}

impl Solution {
    pub fn can_divide_into_groups(nums: Vec<i32>, k: i32) -> bool {
        let n = nums.len();
        let max_num = *nums.iter().max().unwrap() as usize;
        let mut prime_factors = HashMap::new();

        for num in &nums {
            let num = *num as usize;
            let mut x = num;
            for i in 2..=((x as f64).sqrt() as usize) {
                if x % i == 0 {
                    prime_factors.entry(i).or_insert(HashSet::new()).insert(num);
                    while x % i == 0 {
                        x /= i;
                    }
                }
            }
            if x > 1 {
                prime_factors.entry(x).or_insert(HashSet::new()).insert(num);
            }
        }

        let mut uf = UnionFind::new(max_num + 1);

        for (_, group) in prime_factors {
            let mut group = group.into_iter().collect::<Vec<_>>();
            if group.is_empty() {
                continue;
            }
            let first = group[0];
            for &num in &group[1..] {
                uf.union(first, num);
            }
        }

        let mut groups = HashMap::new();
        for &num in &nums {
            let num = num as usize;
            let root = uf.find(num);
            groups.entry(root).or_insert(0);
            *groups.get_mut(&root).unwrap() += 1;
        }

        for &count in groups.values() {
            if count < k as usize {
                return false;
            }
        }

        true
    }
}
}