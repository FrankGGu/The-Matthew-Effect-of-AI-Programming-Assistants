use std::collections::HashSet;

impl Solution {
    pub fn maximize_square_area(n: i32, m: i32, h_fences: Vec<i32>, v_fences: Vec<i32>) -> i64 {
        let mut h_fences_sorted = h_fences;
        h_fences_sorted.push(1);
        h_fences_sorted.push(n);
        h_fences_sorted.sort();

        let mut v_fences_sorted = v_fences;
        v_fences_sorted.push(1);
        v_fences_sorted.push(m);
        v_fences_sorted.sort();

        let mut h_diffs = HashSet::new();
        for i in 0..h_fences_sorted.len() {
            for j in i+1..h_fences_sorted.len() {
                h_diffs.insert(h_fences_sorted[j] - h_fences_sorted[i]);
            }
        }

        let mut v_diffs = HashSet::new();
        for i in 0..v_fences_sorted.len() {
            for j in i+1..v_fences_sorted.len() {
                v_diffs.insert(v_fences_sorted[j] - v_fences_sorted[i]);
            }
        }

        let mut max_side = 0;
        for &h_diff in &h_diffs {
            if v_diffs.contains(&h_diff) {
                max_side = max_side.max(h_diff);
            }
        }

        if max_side == 0 {
            return -1;
        }

        (max_side as i64) * (max_side as i64) % 1000000007
    }
}