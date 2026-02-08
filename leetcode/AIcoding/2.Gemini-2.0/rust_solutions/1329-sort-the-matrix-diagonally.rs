impl Solution {
    pub fn diagonal_sort(mat: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let m = mat.len();
        let n = mat[0].len();
        let mut mat = mat;

        use std::collections::HashMap;
        let mut diagonals: HashMap<i32, Vec<i32>> = HashMap::new();

        for i in 0..m {
            for j in 0..n {
                let diagonal_index = i as i32 - j as i32;
                diagonals.entry(diagonal_index).or_insert(vec![]).push(mat[i][j]);
            }
        }

        for (_, diagonal) in diagonals.iter_mut() {
            diagonal.sort();
        }

        let mut result: Vec<Vec<i32>> = vec![vec![0; n]; m];
        let mut diagonals_index: HashMap<i32, usize> = HashMap::new();

        for i in 0..m {
            for j in 0..n {
                let diagonal_index = i as i32 - j as i32;
                let index = diagonals_index.entry(diagonal_index).or_insert(0);
                result[i][j] = diagonals.get(&diagonal_index).unwrap()[*index];
                *index += 1;
            }
        }

        result
    }
}