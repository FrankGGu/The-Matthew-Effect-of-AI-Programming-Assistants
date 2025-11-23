impl Solution {
    pub fn max_count(m: i32, n: i32, ops: Vec<Vec<i32>>) -> i32 {
        if ops.is_empty() {
            return m * n;
        }
        let min_a = ops.iter().map(|op| op[0]).min().unwrap();
        let min_b = ops.iter().map(|op| op[1]).min().unwrap();
        min_a * min_b
    }
}