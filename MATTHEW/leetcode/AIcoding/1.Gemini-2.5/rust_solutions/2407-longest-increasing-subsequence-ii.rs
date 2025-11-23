struct SegmentTree {
    tree: Vec<i32>,
    n: usize,
}

impl SegmentTree {
    fn new(max_val: usize) -> Self {
        let n = max_val;
        SegmentTree {
            tree: vec![0; 4 * n],
            n,
        }
    }

    fn update(&mut self, idx: usize, val: i32) {
        self._update(1, 1, self.n, idx, val);
    }

    fn _update(&mut self, node: usize, start: usize, end: usize, idx: usize, val: i32) {
        if start == end {
            self.tree[node] = self.tree[node].max(val);
            return;
        }

        let mid = start + (end - start) / 2;
        if start <= idx && idx <= mid {
            self._update(2 * node, start, mid, idx, val);
        } else {
            self._update(2 * node + 1, mid + 1, end, idx, val);
        }
        self.tree[node] = self.tree[2 * node].max(self.tree[2 * node + 1]);
    }

    fn query(&mut self, l: usize, r: usize) -> i32 {
        if l > r {
            return 0;
        }
        self._query(1, 1, self.n, l, r)
    }

    fn _query(&mut self, node: usize, start: usize, end: usize, l: usize, r: usize) -> i32 {
        if r < start || end < l {
            return 0;
        }

        if l <= start && end <= r {
            return self.tree[node];
        }

        let mid = start + (end - start) / 2;
        let p1 = self._query(2 * node, start, mid, l, r);
        let p2 = self._query(2 * node + 1, mid + 1, end, l, r);
        p1.max(p2)
    }
}

impl Solution {
    pub fn longest_increasing_subsequence(nums: Vec<i32>, k: i32) -> i32 {
        let max_val = 100000;
        let mut st = SegmentTree::new(max_val);
        let mut max_lis_len = 0;

        for &num in nums.iter() {
            let num_usize = num as usize;
            let low_bound = (num - k).max(1) as usize;
            let high_bound = (num - 1) as usize;

            let prev_max_len = st.query(low_bound, high_bound);

            let current_len = 1 + prev_max_len;

            st.update(num_usize, current_len);

            max_lis_len = max_lis_len.max(current_len);
        }

        max_lis_len
    }
}