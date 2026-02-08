impl Solution {
    pub fn rotate_the_box(box_vec: Vec<Vec<char>>) -> Vec<Vec<char>> {
        let m = box_vec.len();
        let n = box_vec[0].len();

        let mut rotated_box: Vec<Vec<char>> = vec![vec!['.'; m]; n];

        for r in 0..m {
            for c in 0..n {
                let new_r = c;
                let new_c = m - 1 - r;
                rotated_box[new_r][new_c] = box_vec[r][c];
            }
        }

        for c in 0..m {
            let mut empty_slot_row = n - 1;

            for r in (0..n).rev() {
                if rotated_box[r][c] == '#' {
                    if r != empty_slot_row {
                        rotated_box[empty_slot_row][c] = '#';
                        rotated_box[r][c] = '.';
                    }
                    empty_slot_row -= 1;
                } else if rotated_box[r][c] == '*' {
                    empty_slot_row = r - 1;
                }
            }
        }

        rotated_box
    }
}