use std::collections::HashMap;

impl Solution {
    pub fn diagonal_sort(mut mat: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let m = mat.len();
        if m == 0 {
            return mat;
        }
        let n = mat[0].len();
        if n == 0 {
            return mat;
        }

        let mut diagonals: HashMap<i32, Vec<i32>> = HashMap::new();

        for r in 0..m {
            for c in 0..n {
                diagonals.entry((r as i32) - (c as i32))
                         .or_insert_with(Vec::new)
                         .push(mat[r][c]);
            }
        }

        for (_key, vec) in diagonals.iter_mut() {
            vec.sort_unstable();
        }

        let mut diagonal_pointers: HashMap<i32, usize> = HashMap::new();

        for r in 0..m {
            for c in 0..n {
                let diag_key = (r as i32) - (c as i32);
                let current_index = diagonal_pointers.entry(diag_key).or_insert(0);

                let sorted_vec = diagonals.get(&diag_key).unwrap();

                mat[r][c] = sorted_vec[*current_index];

                *current_index += 1;
            }
        }

        mat
    }
}