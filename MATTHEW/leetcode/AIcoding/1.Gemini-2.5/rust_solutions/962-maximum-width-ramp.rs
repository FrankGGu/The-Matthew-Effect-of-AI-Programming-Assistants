impl Solution {
    pub fn max_width_ramp(a: Vec<i32>) -> i32 {
        let n = a.len();
        if n < 2 {
            return 0;
        }

        let mut indexed_a: Vec<(i32, usize)> = Vec::with_capacity(n);
        for (i, &val) in a.iter().enumerate() {
            indexed_a.push((val, i));
        }

        indexed_a.sort_unstable_by_key(|&(val, _)| val);

        let mut max_width = 0;
        let mut min_idx_so_far = indexed_a[0].1;

        for i in 1..n {
            let current_idx = indexed_a[i].1;
            max_width = max_width.max(current_idx as i32 - min_idx_so_far as i32);
            min_idx_so_far = min_idx_so_far.min(current_idx);
        }

        max_width
    }
}