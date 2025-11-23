impl Solution {
    pub fn min_swaps(grid: Vec<Vec<i32>>) -> i32 {
        let n = grid.len();
        let mut current_row_zeros: Vec<usize> = Vec::with_capacity(n);

        for r_idx in 0..n {
            let mut count = 0;
            for c_idx in (0..n).rev() {
                if grid[r_idx][c_idx] == 0 {
                    count += 1;
                } else {
                    break;
                }
            }
            current_row_zeros.push(count);
        }

        let mut total_swaps = 0;

        for i in 0..n {
            let required_zeros = n - 1 - i;

            let mut found_idx = None;
            for j in i..n {
                if current_row_zeros[j] >= required_zeros {
                    found_idx = Some(j);
                    break;
                }
            }

            match found_idx {
                Some(actual_j) => {
                    total_swaps += (actual_j - i) as i32;
                    let val = current_row_zeros.remove(actual_j);
                    current_row_zeros.insert(i, val);
                }
                None => {
                    return -1;
                }
            }
        }

        total_swaps
    }
}