struct DSU {
    parent: Vec<usize>,
    size: Vec<i64>,
}

impl DSU {
    fn new(n: usize) -> Self {
        let mut parent = vec![0; n];
        for i in 0..n {
            parent[i] = i;
        }
        DSU {
            parent,
            size: vec![0; n],
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
            self.parent[root_x] = root_y;
            self.size[root_y] += self.size[root_x];
        }
    }
}

impl Solution {
    pub fn maximum_segment_sum_after_removals(nums: Vec<i32>, remove_queries: Vec<i32>) -> Vec<i64> {
        let n = nums.len();
        let mut result = vec![0; n];
        let mut dsu = DSU::new(n);
        let mut segments = vec![0; n];
        let mut max_sum = 0;

        for i in (0..n).rev() {
            let index = remove_queries[i] as usize;
            dsu.size[index] = nums[index] as i64;

            if index > 0 && dsu.size[index - 1] > 0 {
                dsu.union(index - 1, index);
            }
            if index < n - 1 && dsu.size[index + 1] > 0 {
                dsu.union(index, index + 1);
            }

            max_sum = max_sum.max(dsu.size[dsu.find(index)]);
            result[i] = max_sum;
        }

        result.pop();
        result
    }
}