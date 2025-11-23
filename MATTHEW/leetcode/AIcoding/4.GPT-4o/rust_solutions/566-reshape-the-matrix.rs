impl Solution {
    pub fn matrix_reshape(mat: Vec<Vec<i32>>, r: i32, c: i32) -> Vec<Vec<i32>> {
        let (m, n) = (mat.len(), mat[0].len());
        if m * n != (r * c) as usize {
            return mat;
        }
        let mut reshaped = Vec::new();
        let mut flat: Vec<i32> = mat.into_iter().flat_map(|row| row).collect();
        for i in 0..r {
            reshaped.push(flat.drain(0..c as usize).collect());
        }
        reshaped
    }
}