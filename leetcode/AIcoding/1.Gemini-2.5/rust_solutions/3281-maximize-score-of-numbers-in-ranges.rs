struct SegmentTree {
    tree: Vec<i64>,
    n: usize,
}

impl SegmentTree {
    fn new(size: usize) -> Self {
        SegmentTree {
            tree: vec![0; 4 * size],
            n: size,
        }
    }

    fn update_recursive(&mut self, node: usize, start: usize, end: usize, idx: usize, val: i64) {
        if start == end {
            self.tree[node] = self.tree[node].max(val);
        } else {
            let mid = start + (end - start) / 2;
            if idx <= mid {
                self.update_recursive(2 * node, start, mid, idx, val);
            } else {
                self.update_recursive(2 * node + 1, mid + 1, end, idx, val);
            }
            self.tree[node] = self.tree[2 * node].max(self.tree[2 * node + 1]);
        }
    }

    fn query_recursive(&self, node: usize, start: usize, end: usize, l: usize, r: usize) -> i64 {
        if r < start || end < l {
            return 0;
        }
        if l <= start && end <= r {
            return self.tree[node];
        }
        let mid = start + (end - start) / 2;
        let p1 = self.query_recursive(2 * node, start, mid, l, r);
        let p2 = self.query_recursive(2 * node + 1, mid + 1, end, l, r);
        p1.max(p2)
    }

    fn update(&mut self, idx: usize, val: i64) {
        if idx < self.n {
            self.update_recursive(1, 0, self.n - 1, idx, val);
        }
    }

    fn query(&self, l: usize, r: usize) -> i64 {
        if l > r || l >= self.n { return 0; }
        let actual_r = r.min(self.n - 1);
        self.query_recursive(1, 0, self.n - 1, l, actual_r)
    }
}

impl Solution {
    pub fn maximize_score(nums: Vec<i32>, queries: Vec<Vec<i32>>) -> Vec<i64> {
        let n = nums.len();

        let mut left = vec![-1; n];
        let mut right = vec![n as i32; n];
        let mut stack: Vec<usize> = Vec::new();

        for i in 0..n {
            while !stack.is_empty() && nums[*stack.last().unwrap()] >= nums[i] {
                stack.pop();
            }
            if !stack.is_empty() {
                left[i] = *stack.last().unwrap() as i32;
            }
            stack.push(i);
        }

        stack.clear();

        for i in (0..n).rev() {
            while !stack.is_empty() && nums[*stack.last().unwrap()] >= nums[i] {
                stack.pop();
            }
            if !stack.is_empty() {
                right[i] = *stack.last().unwrap() as i32;
            }
            stack.push(i);
        }

        let mut points: Vec<(i64, usize, usize)> = Vec::with_capacity(n);
        for i in 0..n {
            let score = nums[i] as i64 * (right[i] - left[i] - 1) as i64;
            let left_mapped = (left[i] + 1) as usize;
            let right_val = right[i] as usize;
            points.push((score, left_mapped, right_val));
        }

        points.sort_unstable_by(|a, b| b.2.cmp(&a.2));

        let mut queries_with_idx: Vec<(usize, usize, usize)> = Vec::with_capacity(queries.len());
        for (idx, q) in queries.into_iter().enumerate() {
            queries_with_idx.push((q[0] as usize, q[1] as usize, idx));
        }

        queries_with_idx.sort_unstable_by(|a, b| b.1.cmp(&a.1));

        let mut seg_tree = SegmentTree::new(n + 1);
        let mut results = vec![0; queries_with_idx.len()];
        let mut point_ptr = 0;

        for j in 0..queries_with_idx.len() {
            let current_query = &queries_with_idx[j];
            let q_start = current_query.0;
            let q_end = current_query.1;
            let q_original_idx = current_query.2;

            while point_ptr < points.len() && points[point_ptr].2 >= q_end + 1 {
                let score = points[point_ptr].0;
                let left_mapped = points[point_ptr].1;
                seg_tree.update(left_mapped, score);
                point_ptr += 1;
            }

            let max_score = seg_tree.query(0, q_start);
            results[q_original_idx] = max_score;
        }

        results
    }
}