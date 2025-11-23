struct DSU {
    parent: Vec<usize>,
    sum: Vec<i64>,
}

impl DSU {
    fn new(n: usize) -> Self {
        DSU {
            parent: (0..n).collect(),
            sum: vec![0; n],
        }
    }

    fn find(&mut self, i: usize) -> usize {
        if self.parent[i] == i {
            i
        } else {
            let root = self.find(self.parent[i]);
            self.parent[i] = root;
            root
        }
    }

    fn union(&mut self, i: usize, j: usize) {
        let root_i = self.find(i);
        let root_j = self.find(j);
        if root_i != root_j {
            self.sum[root_j] += self.sum[root_i];
            self.parent[root_i] = root_j;
        }
    }
}

impl Solution {
    pub fn maximum_segment_sum(nums: Vec<i32>, removals: Vec<i32>) -> Vec<i64> {
        let n = nums.len();
        let m = removals.len();
        let mut ans = vec![0; m];

        let mut dsu = DSU::new(n);
        let mut present = vec![false; n];

        let mut current_max_sum: i64 = 0;

        for k in (0..m).rev() {
            let idx = removals[k] as usize;
            present[idx] = true;

            dsu.sum[idx] = nums[idx] as i64;
            current_max_sum = current_max_sum.max(dsu.sum[idx]);

            if idx > 0 && present[idx - 1] {
                dsu.union(idx, idx - 1);
                current_max_sum = current_max_sum.max(dsu.sum[dsu.find(idx)]);
            }

            if idx < n - 1 && present[idx + 1] {
                dsu.union(idx, idx + 1);
                current_max_sum = current_max_sum.max(dsu.sum[dsu.find(idx)]);
            }

            ans[k] = current_max_sum;
        }

        ans
    }
}