impl Solution {
    pub fn construct_2d_array(original: Vec<i32>, m: i32, n: i32) -> Vec<Vec<i32>> {
        let m = m as usize;
        let n = n as usize;

        if original.len() != m * n {
            return vec![];
        }

        original
            .chunks(n)
            .map(|chunk| chunk.to_vec())
            .collect()
    }
}