impl Solution {
    pub fn rotate_the_box(boxes: Vec<Vec<char>>) -> Vec<Vec<char>> {
        let m = boxes.len();
        let n = boxes[0].len();
        let mut result = vec![vec!['.'; m]; n];

        for j in 0..n {
            let mut k = m - 1;
            for i in (0..m).rev() {
                if boxes[i][j] == '#' {
                    result[j][k] = '#';
                    k -= 1;
                } else if boxes[i][j] == '*' {
                    k = k.min(i as i32 - 1);
                }
            }
            for r in (0..=k) {
                result[j][r] = '.';
            }
        }

        result
    }
}