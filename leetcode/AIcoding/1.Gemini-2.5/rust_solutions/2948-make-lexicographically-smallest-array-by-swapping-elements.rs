use std::collections::{HashMap, VecDeque};

struct DSU {
    parent: Vec<usize>,
    size: Vec<usize>,
}

impl DSU {
    fn new(n: usize) -> Self {
        DSU {
            parent: (0..n).collect(),
            size: vec![1; n],
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

    fn union(&mut self, i: usize, j: usize) {
        let mut root_i = self.find(i);
        let mut root_j = self.find(j);

        if root_i != root_j {
            if self.size[root_i] < self.size[root_j] {
                std::mem::swap(&mut root_i, &mut root_j);
            }
            self.parent[root_j] = root_i;
            self.size[root_i] += self.size[root_j];
        }
    }
}

impl Solution {
    pub fn make_lexicographically_smallest_array(nums: Vec<i32>, limit: i32) -> Vec<i32> {
        let n = nums.len();
        if n <= 1 {
            return nums;
        }

        let mut indexed_nums: Vec<(i32, usize)> = nums.iter().enumerate().map(|(i, &v)| (v, i)).collect();
        indexed_nums.sort_unstable();

        let mut dsu = DSU::new(n);

        let mut window: VecDeque<(i32, usize)> = VecDeque::new();

        for &(val, original_idx) in indexed_nums.iter() {
            while let Some(&(prev_val, _)) = window.front() {
                if val - prev_val > limit {
                    window.pop_front();
                } else {
                    break;
                }
            }

            if let Some(&(_, first_idx_in_window)) = window.front() {
                dsu.union(original_idx, first_idx_in_window);
            }

            window.push_back((val, original_idx));
        }

        let mut components: HashMap<usize, (Vec<i32>, Vec<usize>)> = HashMap::new();

        for i in 0..n {
            let root = dsu.find(i);
            let entry = components.entry(root).or_insert((Vec::new(), Vec::new()));
            entry.0.push(nums[i]);
            entry.1.push(i);
        }

        let mut ans = vec![0; n];
        for (_, (mut values, mut indices)) in components {
            values.sort_unstable();
            indices.sort_unstable();
            for (i, &val) in values.iter().enumerate() {
                ans[indices[i]] = val;
            }
        }

        ans
    }
}