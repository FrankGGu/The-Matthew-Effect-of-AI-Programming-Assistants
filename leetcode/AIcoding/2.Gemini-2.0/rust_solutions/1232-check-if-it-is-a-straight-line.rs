impl Solution {
    pub fn check_straight_line(coordinates: Vec<Vec<i32>>) -> bool {
        if coordinates.len() <= 2 {
            return true;
        }

        let x0 = coordinates[0][0];
        let y0 = coordinates[0][1];
        let x1 = coordinates[1][0];
        let y1 = coordinates[1][1];

        for i in 2..coordinates.len() {
            let x = coordinates[i][0];
            let y = coordinates[i][1];

            if (y1 - y0) * (x - x0) != (y - y0) * (x1 - x0) {
                return false;
            }
        }

        true
    }
}