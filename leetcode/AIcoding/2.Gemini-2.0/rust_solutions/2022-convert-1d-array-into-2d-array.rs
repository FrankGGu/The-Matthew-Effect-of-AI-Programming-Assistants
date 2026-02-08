impl Solution {
    pub fn construct2_d_array(original: Vec<i32>, m: i32, n: i32) -> Vec<Vec<i32>> {
        let m = m as usize;
        let n = n as usize;
        let len = original.len();

        if len != m * n {
            return Vec::new();
        }

        let mut result: Vec<Vec<i32>> = Vec::with_capacity(m);
        for i in 0..m {
            let mut row: Vec<i32> = Vec::with_capacity(n);
            for j in 0..n {
                row.push(original[i * n + j]);
            }
            result.push(row);
        }

        result
    }
}