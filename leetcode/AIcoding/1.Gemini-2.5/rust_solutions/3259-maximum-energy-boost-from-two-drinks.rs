use std::collections::HashMap;

struct SegmentTree {
    tree: Vec<i32>,
    size: usize,
}

impl SegmentTree {
    fn new(size: usize) -> Self {
        SegmentTree {
            tree: vec![0; 4 * size],
            size,
        }
    }

    fn update(&mut self, idx: usize, val: i32) {
        if self.size == 0 {
            return;
        }
        self._update(1, 0, self.size - 1, idx, val);
    }

    fn _update(&mut self, node: usize, start: usize, end: usize, idx: usize, val: i32) {
        if start == end {
            self.tree[node] = self.tree[node].max(val);
        } else {
            let mid = start + (end - start) / 2;
            if idx <= mid {
                self._update(2 * node, start, mid, idx, val);
            } else {
                self._update(2 * node + 1, mid + 1, end, idx, val);
            }
            self.tree[node] = self.tree[2 * node].max(self.tree[2 * node + 1]);
        }
    }

    fn query(&self, l: usize, r: usize) -> i32 {
        if self.size == 0 || l > r {
            return 0;
        }
        self._query(1, 0, self.size - 1, l, r)
    }

    fn _query(&self, node: usize, start: usize, end: usize, l: usize, r: usize) -> i32 {
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
    pub fn maximum_energy_boost_from_two_drinks(drinks: Vec<Vec<i32>>, k: i32) -> i32 {
        let mut drinks_tuples: Vec<(i32, i32)> = drinks.into_iter().map(|d| (d[1], d[0])).collect();
        drinks_tuples.sort_unstable();

        let mut max_total_energy = 0;

        // Step 1: Handle buying one drink
        for &(cost, energy) in &drinks_tuples {
            if cost <= k {
                max_total_energy = max_total_energy.max(energy);
            }
        }

        let n = drinks_tuples.len();
        if n < 2 {
            return max_total_energy;
        }

        // Coordinate compression for costs
        let mut all_costs: Vec<i32> = drinks_tuples.iter().map(|&(c, _)| c).collect();
        all_costs.sort_unstable();
        all_costs.dedup();

        let mut cost_to_idx: HashMap<i32, usize> = HashMap::new();
        for (idx, &cost) in all_costs.iter().enumerate() {
            cost_to_idx.insert(cost, idx);
        }
        let num_unique_costs = all_costs.len();

        // Step 2: Handle buying two distinct drinks
        let mut left_segment_tree = SegmentTree::new(num_unique_costs);
        let mut max_energy_from_left_partners: Vec<i32> = vec![0; n];

        // Left-to-right pass
        for i in 0..n {
            let (c_i, e_i) = drinks_tuples[i];
            let target_cost_j = k - c_i;

            if target_cost_j >= 0 {
                let p_idx_upper_bound = all_costs.partition_point(|&cost_val| cost_val <= target_cost_j);
                if p_idx_upper_bound > 0 {
                    let p = p_idx_upper_bound - 1;
                    let max_e_j_from_left_st = left_segment_tree.query(0, p);
                    max_energy_from_left_partners[i] = max_e_j_from_left_st;
                }
            }

            let cost_idx_i = *cost_to_idx.get(&c_i).unwrap();
            left_segment_tree.update(cost_idx_i, e_i);
        }

        let mut right_segment_tree = SegmentTree::new(num_unique_costs);

        // Right-to-left pass
        for i in (0..n).rev() {
            let (c_i, e_i) = drinks_tuples[i];
            let target_cost_j = k - c_i;

            if target_cost_j >= 0 {
                let p_idx_upper_bound = all_costs.partition_point(|&cost_val| cost_val <= target_cost_j);
                if p_idx_upper_bound > 0 {
                    let p = p_idx_upper_bound - 1;
                    let max_e_j_from_right_st = right_segment_tree.query(0, p);
                    max_total_energy = max_total_energy.max(e_i + max_e_j_from_right_st);
                }
            }

            max_total_energy = max_total_energy.max(e_i + max_energy_from_left_partners[i]);

            let cost_idx_i = *cost_to_idx.get(&c_i).unwrap();
            right_segment_tree.update(cost_idx_i, e_i);
        }

        max_total_energy
    }
}