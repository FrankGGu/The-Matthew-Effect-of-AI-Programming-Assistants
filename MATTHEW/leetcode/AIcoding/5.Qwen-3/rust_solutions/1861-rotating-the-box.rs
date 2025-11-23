impl Solution {
    pub fn rotate_the_box(mut box_: Vec<Vec<char>>) -> Vec<Vec<char>> {
        let m = box_.len();
        let n = box_[0].len();

        for row in &mut box_ {
            let mut i = n as i32 - 1;
            for j in (0..n).rev() {
                if row[j] == '*' {
                    i = j as i32 - 1;
                } else if row[j] == '#' {
                    if i >= 0 {
                        row[i as usize] = '#';
                        row[j] = '.';
                        i -= 1;
                    }
                }
            }
        }

        let mut result = vec![vec!['.'; m]; n];
        for i in 0..m {
            for j in 0..n {
                result[j][m - 1 - i] = box_[i][j];
            }
        }

        result
    }
}