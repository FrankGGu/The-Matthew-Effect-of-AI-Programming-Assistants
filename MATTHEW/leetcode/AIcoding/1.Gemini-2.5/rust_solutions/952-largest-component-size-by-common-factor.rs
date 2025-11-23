use std::collections::HashMap;

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
            return i;
        }
        self.parent[i] = self.find(self.parent[i]);
        self.parent[i]
    }

    fn union(&mut self, i: usize, j: usize) {
        let root_i = self.find(i);
        let root_j = self.find(j);
        if root_i != root_j {
            self.parent[root_j] = root_i;
        }
    }
}

impl Solution {
    pub fn largest_component_size(nums: Vec<i32>) -> i32 {
        if nums.is_empty() {
            return 0;
        }

        let max_val = *nums.iter().max().unwrap() as usize;
        let mut dsu = DSU::new(max_val + 1);

        for &num_i32 in nums.iter() {
            let mut num = num_i32 as usize;
            let original_num = num_i32 as usize;

            let mut d = 2;
            while d * d <= num {
                if num % d == 0 {
                    dsu.union(original_num, d);
                    while num % d == 0 {
                        num /= d;
                    }
                }
                d += 1;
            }
            if num > 1 {
                dsu.union(original_num, num);
            }
        }

        let mut component_counts: HashMap<usize, usize> = HashMap::new();
        for &num_i32 in nums.iter() {
            let root = dsu.find(num_i32 as usize);
            *component_counts.entry(root).or_insert(0) += 1;
        }

        *component_counts.values().max().unwrap_or(&0) as i32
    }
}