impl Solution {
    pub fn max_trailing_zeros(grid: Vec<Vec<i32>>) -> i32 {
        let m = grid.len();
        let n = grid[0].len();

        let mut row_two = vec![vec![0; n]; m];
        let mut row_five = vec![vec![0; n]; m];
        let mut col_two = vec![vec![0; n]; m];
        let mut col_five = vec![vec![0; n]; m];

        for i in 0..m {
            for j in 0..n {
                let mut val = grid[i][j];
                while val > 0 && val % 2 == 0 {
                    row_two[i][j] += 1;
                    val /= 2;
                }
                val = grid[i][j];
                while val > 0 && val % 5 == 0 {
                    row_five[i][j] += 1;
                    val /= 5;
                }
            }
        }

        for j in 0..n {
            for i in 0..m {
                let mut val = grid[i][j];
                while val > 0 && val % 2 == 0 {
                    col_two[i][j] += 1;
                    val /= 2;
                }
                val = grid[i][j];
                while val > 0 && val % 5 == 0 {
                    col_five[i][j] += 1;
                    val /= 5;
                }
            }
        }

        let mut max_zeros = 0;

        for i in 0..m {
            for j in 0..n {
                let mut top_two = 0;
                let mut top_five = 0;
                let mut bottom_two = 0;
                let mut bottom_five = 0;
                let mut left_two = 0;
                let mut left_five = 0;
                let mut right_two = 0;
                let mut right_five = 0;

                for k in 0..i {
                    top_two += col_two[k][j];
                    top_five += col_five[k][j];
                }
                for k in i + 1..m {
                    bottom_two += col_two[k][j];
                    bottom_five += col_five[k][j];
                }
                for k in 0..j {
                    left_two += row_two[i][k];
                    left_five += row_five[i][k];
                }
                for k in j + 1..n {
                    right_two += row_two[i][k];
                    right_five += row_five[i][k];
                }

                let current_two = row_two[i][j];
                let current_five = row_five[i][j];

                let mut zeros = std::cmp::max(
                    std::cmp::min(left_two + top_two + current_two, left_five + top_five + current_five),
                    std::cmp::min(left_two + bottom_two + current_two, left_five + bottom_five + current_five)
                );
                zeros = std::cmp::max(zeros, std::cmp::min(right_two + top_two + current_two, right_five + top_five + current_five));
                zeros = std::cmp::max(zeros, std::cmp::min(right_two + bottom_two + current_two, right_five + bottom_five + current_five));

                max_zeros = std::cmp::max(max_zeros, zeros);
            }
        }

        max_zeros
    }
}