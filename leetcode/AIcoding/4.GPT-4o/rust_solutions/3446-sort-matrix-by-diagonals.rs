use std::collections::HashMap;

impl Solution {
    pub fn diagonal_sort(mat: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let mut diagonals: HashMap<i32, Vec<i32>> = HashMap::new();

        for i in 0..mat.len() {
            for j in 0..mat[0].len() {
                diagonals.entry((i as i32 - j as i32)).or_insert(Vec::new()).push(mat[i][j]);
            }
        }

        for v in diagonals.values_mut() {
            v.sort_unstable();
        }

        let mut result = mat.clone();

        for i in 0..mat.len() {
            for j in 0..mat[0].len() {
                if let Some(diagonal) = diagonals.get_mut(&(i as i32 - j as i32)) {
                    result[i][j] = diagonal.remove(0);
                }
            }
        }

        result
    }
}