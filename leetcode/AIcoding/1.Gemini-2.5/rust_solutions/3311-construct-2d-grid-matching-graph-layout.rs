struct Solution;

impl Solution {
    pub fn construct_2d_array(original: Vec<i32>, m: i32, n: i32) -> Vec<Vec<i32>> {
        let m_usize = m as usize;
        let n_usize = n as usize;
        let original_len = original.len();

        if original_len != m_usize * n_usize {
            return Vec::new();
        }

        let mut result = vec![vec![0; n_usize]; m_usize];
        for i in 0..original_len {
            let r = i / n_usize;
            let c = i % n_usize;
            result[r][c] = original[i];
        }
        result
    }
}