impl Solution {
    pub fn matrix_sum(n: i32, queries: Vec<Vec<i32>>) -> i64 {
        let mut row_set = std::collections::HashSet::new();
        let mut col_set = std::collections::HashSet::new();
        let mut sum: i64 = 0;
        for query in queries.iter().rev() {
            let type_ = query[0];
            let index = query[1];
            let val = query[2];

            if type_ == 0 {
                if !row_set.contains(&index) {
                    sum += (n as i64 - col_set.len() as i64) * val as i64;
                    row_set.insert(index);
                }
            } else {
                if !col_set.contains(&index) {
                    sum += (n as i64 - row_set.len() as i64) * val as i64;
                    col_set.insert(index);
                }
            }
        }
        sum
    }
}