use std::collections::HashMap;

struct SegmentTree {
    tree: Vec<i32>,
    size: usize,
}

impl SegmentTree {
    fn new(n_leaves: usize) -> Self {
        let mut size = 1;
        while size < n_leaves {
            size *= 2;
        }
        SegmentTree {
            tree: vec![0; 2 * size],
            size,
        }
    }

    fn update(&mut self, mut idx: usize, val: i32) {
        idx += self.size;
        self.tree[idx] = self.tree[idx].max(val);
        while idx > 1 {
            idx /= 2;
            self.tree[idx] = self.tree[2 * idx].max(self.tree[2 * idx + 1]);
        }
    }

    fn query(&self, mut l: usize, mut r: usize) -> i32 {
        l += self.size;
        r += self.size;
        let mut max_val = 0;
        while l <= r {
            if l % 2 == 1 {
                max_val = max_val.max(self.tree[l]);
                l += 1;
            }
            if r % 2 == 0 {
                max_val = max_val.max(self.tree[r]);
                r -= 1;
            }
            l /= 2;
            r /= 2;
        }
        max_val
    }
}

impl Solution {
    pub fn count_covered_buildings(mut buildings: Vec<Vec<i32>>) -> i32 {
        let mut c_coords: Vec<i32> = buildings.iter().map(|b| b[1]).collect();
        c_coords.sort_unstable();
        c_coords.dedup();

        let mut c_to_idx: HashMap<i32, usize> = HashMap::new();
        for (i, &c) in c_coords.iter().enumerate() {
            c_to_idx.insert(c, i);
        }
        let max_c_idx = c_coords.len().saturating_sub(1);

        buildings.sort_unstable_by(|a, b| {
            b[0].cmp(&a[0])
                .then_with(|| b[1].cmp(&a[1]))
                .then_with(|| b[2].cmp(&a[2]))
        });

        let mut seg_tree = SegmentTree::new(c_coords.len());

        let mut uncovered_count = 0;
        for building in buildings {
            let ci = building[1];
            let hi = building[2];

            let c_idx = *c_to_idx.get(&ci).unwrap();

            let max_h_in_range = seg_tree.query(c_idx, max_c_idx);

            if hi > max_h_in_range {
                uncovered_count += 1;
            }

            seg_tree.update(c_idx, hi);
        }

        uncovered_count
    }
}