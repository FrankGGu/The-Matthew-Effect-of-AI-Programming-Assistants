impl Solution {
    pub fn check_straight_line(coordinates: Vec<Vec<i32>>) -> bool {
        if coordinates.len() <= 2 {
            return true;
        }

        let x0 = coordinates[0][0];
        let y0 = coordinates[0][1];
        let x1 = coordinates[1][0];
        let y1 = coordinates[1][1];

        let ref_dx = x1 - x0;
        let ref_dy = y1 - y0;

        for i in 2..coordinates.len() {
            let xi = coordinates[i][0];
            let yi = coordinates[i][1];

            let curr_dx = xi - x0;
            let curr_dy = yi - y0;

            // Check collinearity using cross-multiplication to avoid division by zero
            // (y_i - y_0) / (x_i - x_0) == (y_1 - y_0) / (x_1 - x_0)
            // (y_i - y_0) * (x_1 - x_0) == (y_1 - y_0) * (x_i - x_0)
            if curr_dy * ref_dx != ref_dy * curr_dx {
                return false;
            }
        }

        true
    }
}