impl Solution {
    pub fn construct_2d_array(original: Vec<i32>, m: i32, n: i32) -> Vec<Vec<i32>> {
        if original.len() != (m * n) as usize {
            return vec![];
        }
        let mut result = Vec::with_capacity(m as usize);
        for i in 0..m {
            let start = (i * n) as usize;
            let end = start + n as usize;
            result.push(original[start..end].to_vec());
        }
        result
    }
}