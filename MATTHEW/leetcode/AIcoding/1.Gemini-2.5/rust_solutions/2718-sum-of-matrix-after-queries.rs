struct Solution;

impl Solution {
    pub fn matrix_sum_queries(n: i32, queries: Vec<Vec<i32>>) -> i64 {
        let n_usize = n as usize;
        let mut row_covered = vec![false; n_usize];
        let mut col_covered = vec![false; n_usize];
        let mut total_sum: i64 = 0;
        let mut rows_covered_count: usize = 0;
        let mut cols_covered_count: usize = 0;

        for i in (0..queries.len()).rev() {
            let query = &queries[i];
            let query_type = query[0];
            let index = query[1] as usize;
            let val = query[2] as i64;

            if query_type == 0 { // Row query
                if !row_covered[index] {
                    total_sum += val * (n as i64 - cols_covered_count as i64);
                    row_covered[index] = true;
                    rows_covered_count += 1;
                }
            } else { // Column query
                if !col_covered[index] {
                    total_sum += val * (n as i64 - rows_covered_count as i64);
                    col_covered[index] = true;
                    cols_covered_count += 1;
                }
            }
        }

        total_sum
    }
}