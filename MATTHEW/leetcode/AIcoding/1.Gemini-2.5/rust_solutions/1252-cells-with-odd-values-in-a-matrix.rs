impl Solution {
    pub fn odd_cells(m: i32, n: i32, indices: Vec<Vec<i32>>) -> i32 {
        let m_usize = m as usize;
        let n_usize = n as usize;

        let mut row_counts = vec![0; m_usize];
        let mut col_counts = vec![0; n_usize];

        for index_pair in indices {
            let r = index_pair[0] as usize;
            let c = index_pair[1] as usize;
            row_counts[r] += 1;
            col_counts[c] += 1;
        }

        let mut odd_rows = 0;
        for count in row_counts.iter() {
            if count % 2 != 0 {
                odd_rows += 1;
            }
        }

        let mut odd_cols = 0;
        for count in col_counts.iter() {
            if count % 2 != 0 {
                odd_cols += 1;
            }
        }

        let case1 = odd_rows * (n_usize - odd_cols);
        let case2 = (m_usize - odd_rows) * odd_cols;

        (case1 + case2) as i32
    }
}