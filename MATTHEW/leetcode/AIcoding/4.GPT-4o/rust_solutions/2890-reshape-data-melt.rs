impl Solution {
    pub fn melt(matrix: Vec<Vec<i32>>, r: i32, c: i32) -> Vec<Vec<i32>> {
        let m = matrix.len();
        let n = matrix[0].len();
        if m * n != (r * c) as usize {
            return vec![];
        }

        let mut result = vec![vec![0; c as usize]; r as usize];
        let mut flat = matrix.into_iter().flatten().collect::<Vec<i32>>();

        for i in 0..r {
            for j in 0..c {
                result[i as usize][j as usize] = flat.remove(0);
            }
        }

        result
    }
}