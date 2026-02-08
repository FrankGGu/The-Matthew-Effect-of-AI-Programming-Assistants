use std::collections::HashMap;

struct SegmentTree {
    tree: Vec<i32>,
    size: usize,
}

impl SegmentTree {
    fn new(n: usize) -> Self {
        SegmentTree {
            tree: vec![0; 4 * n],
            size: n,
        }
    }

    fn update(&mut self, idx: usize, val: i32, node: usize, start: usize, end: usize) {
        if start == end {
            self.tree[node] = self.tree[node].max(val);
            return;
        }
        let mid = (start + end) / 2;
        if idx <= mid {
            self.update(idx, val, 2 * node, start, mid);
        } else {
            self.update(idx, val, 2 * node + 1, mid + 1, end);
        }
        self.tree[node] = self.tree[2 * node].max(self.tree[2 * node + 1]);
    }

    fn query(&self, l: usize, r: usize, node: usize, start: usize, end: usize) -> i32 {
        if r < start || end < l {
            return 0;
        }
        if l <= start && end <= r {
            return self.tree[node];
        }
        let mid = (start + end) / 2;
        let p1 = self.query(l, r, 2 * node, start, mid);
        let p2 = self.query(l, r, 2 * node + 1, mid + 1, end);
        p1.max(p2)
    }

    fn update_wrapper(&mut self, idx: usize, val: i32) {
        self.update(idx, val, 1, 0, self.size - 1);
    }

    fn query_wrapper(&self, l: usize, r: usize) -> i32 {
        if l > r {
            return 0;
        }
        self.query(l, r, 1, 0, self.size - 1)
    }
}

fn compress_coordinates(intervals: &Vec<Vec<i32>>) -> (Vec<i32>, HashMap<i32, usize>) {
    let mut coords = Vec::new();
    for interval in intervals.iter() {
        coords.push(interval[0]);
        coords.push(interval[1]);
    }
    coords.sort_unstable();
    coords.dedup();

    let mut coord_to_idx = HashMap::new();
    for (i, &coord) in coords.iter().enumerate() {
        coord_to_idx.insert(coord, i);
    }
    (coords, coord_to_idx)
}

impl Solution {
    pub fn maximize_subarrays_after_removing_one_conflicting_pair(
        pairs: Vec<Vec<i32>>,
    ) -> i32 {
        let mut intervals = pairs;
        if intervals.is_empty() {
            return 0;
        }

        // Sort intervals by start time, then by end time
        intervals.sort_unstable_by(|a, b| {
            if a[0] != b[0] {
                a[0].cmp(&b[0])
            } else {
                a[1].cmp(&b[1])
            }
        });

        let n = intervals.len();

        let (_coords, coord_to_idx) = compress_coordinates(&intervals);
        let num_compressed_coords = coord_to_idx.len();

        // dp_forward[i]: Max non-overlapping intervals from intervals[0...i] ending with intervals[i].
        let mut dp_forward = vec![0; n];
        let mut seg_tree_forward = SegmentTree::new(num_compressed_coords);

        for i in 0..n {
            let s_idx = *coord_to_idx.get(&intervals[i][0]).unwrap();
            let e_idx = *coord_to_idx.get(&intervals[i][1]).unwrap();

            // Query for max dp value from intervals ending before or at current interval's start
            let prev_max = seg_tree_forward.query_wrapper(0, s_idx);
            dp_forward[i] = 1 + prev_max;
            seg_tree_forward.update_wrapper(e_idx, dp_forward[i]);
        }

        // dp_backward[i]: Max non-overlapping intervals from intervals[i...N-1] starting with intervals[i].
        let mut dp_backward = vec![0; n];
        let mut seg_tree_backward = SegmentTree::new(num_compressed_coords);

        for i in (0..n).rev() {
            let s_idx = *coord_to_idx.get(&intervals[i][0]).unwrap();
            let e_idx = *coord_to_idx.get(&intervals[i][1]).unwrap();

            // Query for max dp value from intervals starting after or at current interval's end
            let prev_max = seg_tree_backward.query_wrapper(e_idx, num_compressed_coords - 1);
            dp_backward[i] = 1 + prev_max;
            seg_tree_backward.update_wrapper(s_idx, dp_backward[i]);
        }

        let mut max_overall = 0;
        for &val in dp_forward.iter() {
            max_overall = max_overall.max(val);
        }

        let mut ans = max_overall;

        // Combine dp_forward[i] and dp_backward[j] for i < j where intervals[i] and intervals[j] do not conflict.
        // This effectively finds the max non-overlapping intervals after removing some intervals in between i and j.
        // Iterate i from N-1 down to 0, maintaining a segment tree of dp_backward values for j > i.
        let mut seg_tree_combine = SegmentTree::new(num_compressed_coords);

        for i in (0..n).rev() {
            let e_idx_i = *coord_to_idx.get(&intervals[i][1]).unwrap();

            // Query for max dp_backward[j] such that intervals[j][0] >= intervals[i][1] and j > i.
            // The j > i condition is implicitly handled by iterating backwards and adding dp_backward[i] to the tree after query.
            let query_start_idx = *coord_to_idx.get(&intervals[i][1]).unwrap();
            let max_dp_from_right = seg_tree_combine.query_wrapper(query_start_idx, num_compressed_coords - 1);

            if max_dp_from_right > 0 {
                ans = ans.max(dp_forward[i] + max_dp_from_right);
            }

            // Add current dp_backward[i] to the segment tree for use by intervals to its left (i-1, i-2, ...)
            let s_idx_i = *coord_to_idx.get(&intervals[i][0]).unwrap();
            seg_tree_combine.update_wrapper(s_idx_i, dp_backward[i]);
        }

        ans
    }
}