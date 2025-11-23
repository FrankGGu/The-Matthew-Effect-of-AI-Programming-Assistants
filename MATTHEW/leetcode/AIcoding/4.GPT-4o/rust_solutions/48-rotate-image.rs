impl Solution {
    pub fn rotate(matrix: &mut Vec<Vec<i32>>) {
        let n = matrix.len();
        for i in 0..n {
            for j in i..n {
                matrix.swap(i, j, j, i);
            }
        }
        for row in matrix.iter_mut() {
            row.reverse();
        }
    }
}