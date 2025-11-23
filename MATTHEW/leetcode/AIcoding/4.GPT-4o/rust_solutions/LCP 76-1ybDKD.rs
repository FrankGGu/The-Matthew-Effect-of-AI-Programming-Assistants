impl Solution {
    pub fn magical_chessboard(n: i32) -> bool {
        let mut row_sum = vec![0; n as usize];
        let mut col_sum = vec![0; n as usize];
        let mut total_sum = 0;

        for i in 0..n {
            for j in 0..n {
                total_sum += (i + j) % n;
                row_sum[i as usize] += (i + j) % n;
                col_sum[j as usize] += (i + j) % n;
            }
        }

        let target = total_sum / n;

        for sum in row_sum {
            if sum != target {
                return false;
            }
        }

        for sum in col_sum {
            if sum != target {
                return false;
            }
        }

        true
    }
}