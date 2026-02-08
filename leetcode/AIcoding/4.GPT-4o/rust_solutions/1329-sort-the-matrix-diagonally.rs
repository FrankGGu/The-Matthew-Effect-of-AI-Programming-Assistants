impl Solution {
    pub fn diagonal_sort(mat: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let m = mat.len();
        let n = mat[0].len();
        let mut diagonals = std::collections::HashMap::new();

        for i in 0..m {
            for j in 0..n {
                diagonals.entry(i - j).or_insert(Vec::new()).push(mat[i][j]);
            }
        }

        for v in diagonals.values_mut() {
            v.sort();
        }

        let mut result = vec![vec![0; n]; m];
        for i in 0..m {
            for j in 0..n {
                let diagonal = i - j;
                let value = diagonals.get_mut(&diagonal).unwrap().pop().unwrap();
                result[i][j] = value;
            }
        }
        result
    }
}