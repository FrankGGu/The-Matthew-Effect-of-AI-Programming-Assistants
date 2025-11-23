impl Solution {
    pub fn odd_cells(m: i32, n: i32, indices: Vec<Vec<i32>>) -> i32 {
        let mut rows = vec![0; m as usize];
        let mut cols = vec![0; n as usize];

        for index in indices {
            rows[index[0] as usize] += 1;
            cols[index[1] as usize] += 1;
        }

        let odd_rows = rows.iter().filter(|&&x| x % 2 == 1).count();
        let odd_cols = cols.iter().filter(|&&x| x % 2 == 1).count();

        odd_rows * (n as usize) + odd_cols * (m as usize) - 2 * odd_rows * odd_cols
    }
}