impl Solution {
    pub fn min_operations(mut k: i32) -> i32 {
        if k == 1 {
            return 0;
        }
        let mut min_ops = i32::MAX;
        for a in 1..=k {
            let ops = (a - 1) + ((k + a - 1) / a - 1);
            if ops < min_ops {
                min_ops = ops;
            }
        }
        min_ops
    }
}