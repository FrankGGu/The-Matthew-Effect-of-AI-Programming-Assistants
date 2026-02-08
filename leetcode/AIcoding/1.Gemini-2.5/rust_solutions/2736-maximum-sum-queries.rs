use std::collections::{HashMap, HashSet};

struct SegmentTree {
    tree: Vec<i32>,
    n: usize,
}

impl SegmentTree {
    fn new(size: usize) -> Self {
        SegmentTree {
            tree: vec![i32::MIN; 4 * size],
            n: size,
        }
    }

    fn update_recursive(&mut self, node: usize, start: usize, end: usize, idx: usize, val: i32) {
        if start == end {
            self.tree[node] = self.tree[node].max(val);
            return;
        }

        let mid = start + (end - start) / 2;
        if start <= idx && idx <= mid {
            self.update_recursive(2 * node, start, mid, idx, val);
        } else {
            self.update_recursive(2 * node + 1, mid + 1, end, idx, val);
        }
        self.tree[node] = self.tree[2 * node].max(self.tree[2 * node + 1]);
    }

    fn update(&mut self, idx: usize, val: i32) {
        self.update_recursive(1, 0, self.n - 1, idx, val);
    }

    fn query_recursive(&self, node: usize, start: usize, end: usize, l: usize, r: usize) -> i32 {
        if r < start || end < l {
            return i32::MIN;
        }

        if l <= start && end <= r {
            return self.tree[node];
        }

        let mid = start + (end - start) / 2;
        let p1 = self.query_recursive(2 * node, start, mid, l, r);
        let p2 = self.query_recursive(2 * node + 1, mid + 1, end, l, r);
        p1.max(p2)
    }

    fn query(&self, l: usize, r: usize) -> i32 {
        if l > r || l >= self.n {
            return i32::MIN;
        }
        self.query_recursive(1, 0, self.n - 1, l, r)
    }
}

impl Solution {
    pub fn maximum_sum_queries(nums1: Vec<i32>, nums2: Vec<i32>, queries: Vec<Vec<i32>>) -> Vec<i32> {
        let n = nums1.len();
        let q = queries.len();

        let mut points: Vec<(i32, i32)> = nums1.into_iter().zip(nums2.into_iter()).collect();

        let mut indexed_queries: Vec<(i32, i32, usize)> = queries
            .into_iter()
            .enumerate()
            .map(|(idx, q_vec)| (q_vec[0], q_vec[1], idx))
            .collect();

        let mut all_b_values_set = HashSet::new();
        for &(_, b) in points.iter() {
            all_b_values_set.insert(b);
        }
        for &(_, y, _) in indexed_queries.iter() {
            all_b_values_set.insert(y);
        }

        let mut all_b_values_vec: Vec<i32> = all_b_values_set.into_iter().collect();
        all_b_values_vec.sort_unstable();

        let b_to_compressed_idx: HashMap<i32, usize> = all_b_values_vec
            .iter()
            .enumerate()
            .map(|(idx, &val)| (val, idx))
            .collect();

        let compressed_b_size = all_b_values_vec.len();
        if compressed_b_size == 0 {
            return vec![-1; q];
        }

        points.sort_unstable_by(|a, b| b.0.cmp(&a.0).then_with(|| b.1.cmp(&a.1)));

        indexed_queries.sort_unstable_by(|a, b| b.0.cmp(&a.0));

        let mut results = vec![-1; q];
        let mut st = SegmentTree::new(compressed_b_size);

        let mut point_idx = 0;
        for (x, y, original_idx) in indexed_queries {
            while point_idx < n && points[point_idx].0 >= x {
                let (a, b) = points[point_idx];
                let b_compressed_idx = *b_to_compressed_idx.get(&b).unwrap();
                st.update(b_compressed_idx, a + b);
                point_idx += 1;
            }

            let y_compressed_idx = *b_to_compressed_idx.get(&y).unwrap();
            let max_sum = st.query(y_compressed_idx, compressed_b_size - 1);

            if max_sum != i32::MIN {
                results[original_idx] = max_sum;
            }
        }

        results
    }
}