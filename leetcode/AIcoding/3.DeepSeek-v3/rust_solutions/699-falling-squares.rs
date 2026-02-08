use std::collections::BTreeMap;

struct Solution;

impl Solution {
    pub fn falling_squares(positions: Vec<Vec<i32>>) -> Vec<i32> {
        let mut res = Vec::new();
        let mut intervals = BTreeMap::new();
        let mut max_height = 0;

        for pos in positions {
            let left = pos[0];
            let size = pos[1];
            let right = left + size;
            let mut height = 0;

            let mut to_remove = Vec::new();
            let range = intervals.range(left..right);
            for (&l, &(r, h)) in range {
                if r > left {
                    height = height.max(h);
                }
            }

            let range = intervals.range(..left);
            for (&l, &(r, h)) in range.rev() {
                if r > left {
                    height = height.max(h);
                    break;
                }
            }

            let new_height = height + size;

            let mut left_bound = left;
            let mut right_bound = right;
            let mut merged = false;

            if let Some((&l, &(r, h))) = intervals.range(..left).last() {
                if r == left && h == new_height {
                    left_bound = l;
                    intervals.remove(&l);
                    merged = true;
                }
            }

            if let Some((&l, &(r, h))) = intervals.range(right..).next() {
                if l == right && h == new_height {
                    right_bound = r;
                    intervals.remove(&l);
                    merged = true;
                }
            }

            intervals.insert(left_bound, (right_bound, new_height));

            max_height = max_height.max(new_height);
            res.push(max_height);
        }

        res
    }
}