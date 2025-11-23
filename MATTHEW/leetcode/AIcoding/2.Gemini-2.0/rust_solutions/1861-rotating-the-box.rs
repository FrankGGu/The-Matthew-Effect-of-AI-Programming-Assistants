impl Solution {
    pub fn rotate_the_box(box_: Vec<Vec<char>>) -> Vec<Vec<char>> {
        let m = box_.len();
        let n = box_[0].len();
        let mut rotated = vec![vec!['.'; n]; m];
        for i in 0..m {
            for j in 0..n {
                rotated[i][j] = box_[m - 1 - i][j];
            }
        }

        let mut result = vec![vec!['.'; n]; m];

        for i in 0..m {
            let mut last_obstacle = n;
            for j in (0..n).rev() {
                if rotated[i][j] == '*' {
                    last_obstacle = j;
                } else if rotated[i][j] == '#' {
                    result[i][last_obstacle - 1] = '#';
                    last_obstacle -= 1;
                    rotated[i][j] = '.';
                }
            }
        }

        for i in 0..m {
            for j in 0..n {
                if rotated[i][j] == '*' {
                    result[i][j] = '*';
                }
                if rotated[i][j] == '.' && result[i][j] != '#' {
                    result[i][j] = '.';
                }
            }
        }

        let mut final_result = vec![vec!['.'; n]; m];
        for i in 0..n {
            for j in 0..m {
                final_result[i][m - 1 - j] = result[j][i];
            }
        }

        final_result
    }
}