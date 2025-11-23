use std::collections::{HashMap, HashSet};

const INF: i32 = 1_000_000_001; // A value larger than any possible y-coordinate

struct SegmentTree {
    tree: Vec<i32>,
    n: usize,
}

impl SegmentTree {
    fn new(size: usize) -> Self {
        SegmentTree {
            tree: vec![INF; 4 * size], // 4*size is a safe upper bound for segment tree array
            n: size,
        }
    }

    fn update(&mut self, node: usize, start: usize, end: usize, idx: usize, val: i32) {
        if start == end {
            self.tree[node] = self.tree[node].min(val);
            return;
        }

        let mid = (start + end) / 2;
        if start <= idx && idx <= mid {
            self.update(2 * node, start, mid, idx, val);
        } else {
            self.update(2 * node + 1, mid + 1, end, idx, val);
        }
        self.tree[node] = self.tree[2 * node].min(self.tree[2 * node + 1]);
    }

    fn query(&mut self, node: usize, start: usize, end: usize, l: usize, r: usize) -> i32 {
        // If the current segment is outside the query range
        if r < start || end < l {
            return INF;
        }

        // If the current segment is completely within the query range
        if l <= start && end <= r {
            return self.tree[node];
        }

        // Otherwise, query children and combine results
        let mid = (start + end) / 2;
        let p1 = self.query(2 * node, start, mid, l, r);
        let p2 = self.query(2 * node + 1, mid + 1, end, l, r);
        p1.min(p2)
    }
}

impl Solution {
    pub fn number_of_ways(points: Vec<Vec<i32>>) -> i32 {
        let mut unique_points: Vec<Vec<i32>> = Vec::new();
        let mut seen = HashSet::new();

        for p in points {
            let key = (p[0], p[1]);
            if seen.insert(key) {
                unique_points.push(p);
            }
        }

        // Sort points: primary by x-coordinate ascending, secondary by y-coordinate descending.
        // This order is crucial. When iterating, if x-coordinates are the same,
        // points with higher y-coordinates are processed first.
        unique_points.sort_by(|a, b| {
            if a[0] != b[0] {
                a[0].cmp(&b[0])
            } else {
                b[1].cmp(&a[1]) // Descending y
            }
        });

        // Coordinate compression for y-coordinates
        let mut y_coords: Vec<i32> = unique_points.iter().map(|p| p[1]).collect();
        y_coords.sort_unstable();
        y_coords.dedup();

        let mut y_to_rank: HashMap<i32, usize> = HashMap::new();
        for (i, &y) in y_coords.iter().enumerate() {
            y_to_rank.insert(y, i);
        }

        let n_y = y_coords.len();
        let mut segment_tree = SegmentTree::new(n_y);
        let mut ans = 0;

        for p in unique_points {
            let y = p[1];
            let y_rank = *y_to_rank.get(&y).unwrap();

            // Query the segment tree for the minimum y-value in the range [y_rank, N_y-1].
            // This range corresponds to actual y-values >= current point's y.
            // The segment tree stores the minimum y-value encountered so far for points
            // that have been processed (i.e., to the left of or above the current point)
            // within the queried y-rank range.
            //
            // If the minimum y-value found is strictly greater than the current point's y,
            // it means there's no previously processed point (p_k) such that x_k <= current_x
            // and y_k >= current_y, AND y_k <= current_y.
            // This implies that the current point (p) is a new "lowest" point in its y-range,
            // effectively extending the "lower-right envelope" of points.
            // Such a point can be a valid p2 (bottom-right corner) for some p1 (top-left corner),
            // including itself (p1=p2).
            if segment_tree.query(1, 0, n_y - 1, y_rank, n_y - 1) > y {
                ans += 1;
            }

            // Update the segment tree with the current point's y-value at its y_rank.
            // This ensures that future points to the right and below can be checked against this point.
            // We take the minimum because we are interested in the lowest y-value that has been seen
            // in a given y-range.
            segment_tree.update(1, 0, n_y - 1, y_rank, y);
        }

        ans
    }
}