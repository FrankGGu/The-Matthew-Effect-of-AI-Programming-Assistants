use std::collections::HashMap;

struct SegmentTree {
    base_size: usize, // Smallest power of 2 >= n
    tree: Vec<i32>,
}

impl SegmentTree {
    fn new(n: usize) -> Self {
        let mut base_size = 1;
        while base_size < n {
            base_size *= 2;
        }
        let tree = vec![i32::MAX; 2 * base_size];
        SegmentTree { base_size, tree }
    }

    fn update(&mut self, mut idx: usize, val: i32) {
        idx += self.base_size; // Convert to 1-indexed leaf in the tree array
        self.tree[idx] = val;
        while idx > 1 {
            self.tree[idx / 2] = self.tree[idx].min(self.tree[idx ^ 1]);
            idx /= 2;
        }
    }

    fn query(&self, mut l: usize, mut r: usize) -> i32 {
        l += self.base_size; // Convert to 1-indexed for tree array
        r += self.base_size; // Convert to 1-indexed for tree array
        let mut res = i32::MAX;
        while l <= r {
            if l % 2 == 1 { // If l is a right child
                res = res.min(self.tree[l]);
                l += 1;
            }
            if r % 2 == 0 { // If r is a left child
                res = res.min(self.tree[r]);
                r -= 1;
            }
            l /= 2;
            r /= 2;
        }
        res
    }
}

impl Solution {
    pub fn closest_equal_element_queries(nums: Vec<i32>, queries: Vec<Vec<i32>>) -> Vec<i32> {
        let n = nums.len();

        let mut next_occurrence = vec![n; n];
        let mut last_seen: HashMap<i32, usize> = HashMap::new();
        for i in (0..n).rev() {
            if let Some(&prev_idx) = last_seen.get(&nums[i]) {
                next_occurrence[i] = prev_idx;
            }
            last_seen.insert(nums[i], i);
        }

        let mut events: Vec<(usize, usize, i32)> = Vec::new();
        for i in 0..n {
            if next_occurrence[i] < n {
                events.push((next_occurrence[i], i, (next_occurrence[i] - i) as i32));
            }
        }

        let mut queries_indexed: Vec<(usize, usize, usize)> = Vec::with_capacity(queries.len());
        for (k, query) in queries.iter().enumerate() {
            queries_indexed.push((query[0] as usize, query[1] as usize, k));
        }

        queries_indexed.sort_unstable_by_key(|q| q.1);
        events.sort_unstable_by_key(|e| e.0);

        let mut answers = vec![-1; queries.len()];
        let mut segment_tree = SegmentTree::new(n);

        let mut event_ptr = 0;
        for q_idx in 0..queries_indexed.len() {
            let (l, r, original_query_idx) = queries_indexed[q_idx];

            while event_ptr < events.len() && events[event_ptr].0 <= r {
                let (_, left_idx, distance) = events[event_ptr];
                segment_tree.update(left_idx, distance);
                event_ptr += 1;
            }

            let min_dist = segment_tree.query(l, r);
            if min_dist == i32::MAX {
                answers[original_query_idx] = -1;
            } else {
                answers[original_query_idx] = min_dist;
            }
        }

        answers
    }
}