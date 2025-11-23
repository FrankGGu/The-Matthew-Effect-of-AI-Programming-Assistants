impl Solution {

use std::cmp::Ordering;
use std::collections::HashMap;

impl Solution {
    pub fn diagonal_sort(mat: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let rows = mat.len();
        let cols = mat[0].len();
        let mut diagonals: HashMap<usize, Vec<i32>> = HashMap::new();

        for i in 0..rows {
            for j in 0..cols {
                let key = i - j;
                diagonals.entry(key).or_insert_with(Vec::new).push(mat[i][j]);
            }
        }

        for (_, vec) in diagonals.iter_mut() {
            vec.sort();
        }

        let mut result = mat.clone();

        for i in 0..rows {
            for j in 0..cols {
                let key = i - j;
                let val = diagonals.get_mut(&key).unwrap().pop().unwrap();
                result[i][j] = val;
            }
        }

        result
    }
}
}