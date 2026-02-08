impl Solution {
    pub fn matrix_sum_queries(n: i32, queries: Vec<Vec<i32>>) -> i64 {
        let n = n as usize;
        let mut row_seen = vec![false; n];
        let mut col_seen = vec![false; n];
        let mut row_remaining = n;
        let mut col_remaining = n;
        let mut sum: i64 = 0;

        for query in queries.iter().rev() {
            let typ = query[0];
            let idx = query[1] as usize;
            let val = query[2] as i64;

            if typ == 0 {
                if !row_seen[idx] {
                    sum += val * col_remaining as i64;
                    row_seen[idx] = true;
                    row_remaining -= 1;
                }
            } else {
                if !col_seen[idx] {
                    sum += val * row_remaining as i64;
                    col_seen[idx] = true;
                    col_remaining -= 1;
                }
            }
        }

        sum
    }
}