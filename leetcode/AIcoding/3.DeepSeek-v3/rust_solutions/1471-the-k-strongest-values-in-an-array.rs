impl Solution {
    pub fn get_strongest(mut arr: Vec<i32>, k: i32) -> Vec<i32> {
        arr.sort();
        let n = arr.len();
        let median = arr[(n - 1) / 2];
        arr.sort_by(|a, b| {
            let diff_a = (a - median).abs();
            let diff_b = (b - median).abs();
            if diff_a == diff_b {
                b.cmp(a)
            } else {
                diff_b.cmp(&diff_a)
            }
        });
        arr.into_iter().take(k as usize).collect()
    }
}