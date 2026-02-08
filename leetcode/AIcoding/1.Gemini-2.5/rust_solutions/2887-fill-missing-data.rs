impl Solution {
    pub fn fill_missing_data(mut data: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        if data.is_empty() || data[0].is_empty() {
            return data;
        }

        let rows = data.len();
        let cols = data[0].len();

        let mut col_sums: Vec<i32> = vec![0; cols];
        let mut col_counts: Vec<i32> = vec![0; cols];

        for r in 0..rows {
            for c in 0..cols {
                if data[r][c] != -1 {
                    col_sums[c] += data[r][c];
                    col_counts[c] += 1;
                }
            }
        }

        let mut col_averages: Vec<i32> = vec![0; cols];
        for c in 0..cols {
            if col_counts[c] > 0 {
                col_averages[c] = col_sums[c] / col_counts[c];
            } else {
                col_averages[c] = 0;
            }
        }

        for r in 0..rows {
            for c in 0..cols {
                if data[r][c] == -1 {
                    data[r][c] = col_averages[c];
                }
            }
        }

        data
    }
}