impl Solution {
    pub fn min_operations(k: i332) -> i32 {
        if k == 1 {
            return 0;
        }

        let mut min_ops = k - 1;

        let limit = (k as f64).sqrt() as i32;

        for v in 1..=limit {
            let increment_ops = v - 1;

            let num_copies_needed = (k + v - 1) / v;

            let duplicate_ops = num_copies_needed - 1;

            let total_ops = increment_ops + duplicate_ops;
            min_ops = min_ops.min(total_ops);
        }

        min_ops
    }
}