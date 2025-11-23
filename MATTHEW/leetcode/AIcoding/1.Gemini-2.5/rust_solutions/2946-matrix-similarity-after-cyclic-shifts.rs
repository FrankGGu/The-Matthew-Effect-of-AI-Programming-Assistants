use std::collections::HashMap;

impl Solution {
    pub fn is_matrix_similar(mat: Vec<Vec<i32>>) -> bool {
        let m = mat.len();
        let n = mat[0].len();

        // The problem statement "for some integer k" is interpreted as "there exists a single integer k"
        // that applies to all pairs (r1, c1) and (r2, c2). If 'k' could be chosen independently for
        // each pair, the condition would always be true (by choosing k=0), making the problem trivial.
        // We only need to check k from 0 to n-1 due to the modulo operation.
        for k in 0..n {
            let mut is_similar_for_this_k = true;
            // This map stores, for each value 'X' found in mat[r][c], what value 'Y'
            // mat[r][(c + k) % n] must be. If we find 'X' again at a different (r', c')
            // but mat[r'][(c' + k) % n] is a different value, then this 'k' is invalid.
            let mut value_to_shifted_value_map: HashMap<i32, i32> = HashMap::new();

            for r in 0..m {
                for c in 0..n {
                    let current_val = mat[r][c];
                    let shifted_col_idx = (c + k) % n;
                    let shifted_val = mat[r][shifted_col_idx];

                    match value_to_shifted_value_map.get(&current_val) {
                        Some(&expected_shifted_val) => {
                            // If 'current_val' has been seen before, check if its 'shifted_val'
                            // is consistent with the previously recorded 'expected_shifted_val'.
                            if expected_shifted_val != shifted_val {
                                is_similar_for_this_k = false;
                                break; // Mismatch found, this 'k' is not valid
                            }
                        }
                        None => {
                            // If 'current_val' is seen for the first time, record its 'shifted_val'.
                            value_to_shifted_value_map.insert(current_val, shifted_val);
                        }
                    }
                }
                if !is_similar_for_this_k {
                    break; // Break from outer 'r' loop if a mismatch was found
                }
            }

            // If no mismatches were found for this 'k' across all cells, then the matrix
            // is similar under this 'k'.
            if is_similar_for_this_k {
                return true;
            }
        }

        // If no 'k' from 0 to n-1 makes the matrix similar, return false.
        false
    }
}