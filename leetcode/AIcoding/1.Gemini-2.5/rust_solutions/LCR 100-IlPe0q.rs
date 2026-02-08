impl Solution {
    pub fn minimum_total(triangle: &mut Vec<Vec<i32>>) -> i32 {
        let n = triangle.len();
        if n == 0 {
            return 0;
        }
        if n == 1 {
            return triangle[0][0];
        }

        for r in (0..n - 1).rev() {
            for c in 0..triangle[r].len() {
                let val_below_left = triangle[r + 1][c];
                let val_below_right = triangle[r + 1][c + 1];
                triangle[r][c] += val_below_left.min(val_below_right);
            }
        }

        triangle[0][0]
    }
}