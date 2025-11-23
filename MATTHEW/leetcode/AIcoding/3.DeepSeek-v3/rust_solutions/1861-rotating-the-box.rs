impl Solution {
    pub fn rotate_the_box(box_: Vec<Vec<char>>) -> Vec<Vec<char>> {
        let m = box_.len();
        let n = box_[0].len();
        let mut rotated = vec![vec!['.'; m]; n];

        for i in 0..m {
            let mut pos = n - 1;
            for j in (0..n).rev() {
                match box_[i][j] {
                    '#' => {
                        rotated[j][m - 1 - i] = '#';
                    },
                    '*' => {
                        pos = j;
                        rotated[j][m - 1 - i] = '*';
                    },
                    _ => (),
                }
            }
        }

        for j in 0..rotated[0].len() {
            let mut pos = rotated.len() - 1;
            for i in (0..rotated.len()).rev() {
                if rotated[i][j] == '*' {
                    pos = i - 1;
                } else if rotated[i][j] == '#' {
                    rotated[i][j] = '.';
                    rotated[pos][j] = '#';
                    pos -= 1;
                }
            }
        }

        rotated
    }
}