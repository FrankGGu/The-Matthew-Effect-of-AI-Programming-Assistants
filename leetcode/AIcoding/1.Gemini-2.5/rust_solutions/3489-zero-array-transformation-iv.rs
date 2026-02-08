struct SegmentTree {
    tree: Vec<(i32, usize)>,
    n: usize,
}

impl SegmentTree {
    fn new(nums: &[i32]) -> Self {
        let n = nums.len();
        let mut tree = vec![(0, 0); 4 * n];
        let mut st = SegmentTree { tree, n };
        st.build(nums, 0, 0, n - 1);
        st
    }

    fn build(&mut self, nums: &[i32], node: usize, start: usize, end: usize) {
        if start == end {
            self.tree[node] = (nums[start], start);
        } else {
            let mid = start + (end - start) / 2;
            self.build(nums, 2 * node + 1, start, mid);
            self.build(nums, 2 * node + 2, mid + 1, end);
            self.tree[node] = if self.tree[2 * node + 1].0 <= self.tree[2 * node + 2].0 {
                self.tree[2 * node + 1]
            } else {
                self.tree[2 * node + 2]
            };
        }
    }

    fn query(&self, node: usize, start: usize, end: usize, l: usize, r: usize) -> (i32, usize) {
        if r < start || end < l {
            return (i32::MAX, 0);
        }

        if l <= start && end <= r {
            return self.tree[node];
        }

        let mid = start + (end - start) / 2;
        let p1 = self.query(2 * node + 1, start, mid, l, r);
        let p2 = self.query(2 * node + 2, mid + 1, end, l, r);

        if p1.0 <= p2.0 {
            p1
        } else {
            p2
        }
    }
}

impl Solution {
    pub fn min_operations(nums: Vec<i32>) -> i32 {
        if nums.is_empty() {
            return 0;
        }

        let st = SegmentTree::new(&nums);

        Self::dfs(&nums, 0, nums.len() - 1, 0, &st)
    }

    fn dfs(nums: &[i32], start: usize, end: usize, base_height: i32, st: &SegmentTree) -> i32 {
        if start > end {
            return 0;
        }

        let (min_val, min_idx) = st.query(0, 0, st.n - 1, start, end);

        let mut operations = min_val - base_height;

        if min_idx > start {
            operations += Self::dfs(nums, start, min_idx - 1, min_val, st);
        }

        if min_idx < end {
            operations += Self::dfs(nums, min_idx + 1, end, min_val, st);
        }

        operations
    }
}