impl Solution {
    pub fn maximum_rows(matrix: Vec<Vec<i32>>, cols: i32) -> i32 {
        let m = matrix.len();
        let n = matrix[0].len();
        let mut ans = 0;

        for mask in 0..(1 << n) {
            if mask.count_ones() as i32 != cols {
                continue;
            }

            let mut covered_rows = 0;
            for i in 0..m {
                let mut covered = true;
                for j in 0..n {
                    if matrix[i][j] == 1 && (mask & (1 << j)) == 0 {
                        covered = false;
                        break;
                    }
                }
                if covered {
                    covered_rows += 1;
                }
            }
            ans = ans.max(covered_rows);
        }

        ans
    }
}