impl Solution {
    pub fn maximum_rows(matrix: Vec<Vec<i32>>, num_select: i32) -> i32 {
        let m = matrix.len();
        let n = matrix[0].len();
        let num_select = num_select as usize;
        let mut max_rows = 0;

        let mut cols = vec![0; n];
        Self::backtrack(&matrix, &mut cols, 0, num_select, &mut max_rows);
        max_rows
    }

    fn backtrack(matrix: &Vec<Vec<i32>>, cols: &mut Vec<i32>, start: usize, left: usize, max_rows: &mut i32) {
        if left == 0 {
            let mut count = 0;
            for row in matrix {
                let mut covered = true;
                for (j, &val) in row.iter().enumerate() {
                    if val == 1 && cols[j] == 0 {
                        covered = false;
                        break;
                    }
                }
                if covered {
                    count += 1;
                }
            }
            *max_rows = (*max_rows).max(count);
            return;
        }

        for i in start..cols.len() {
            cols[i] = 1;
            Self::backtrack(matrix, cols, i + 1, left - 1, max_rows);
            cols[i] = 0;
        }
    }
}