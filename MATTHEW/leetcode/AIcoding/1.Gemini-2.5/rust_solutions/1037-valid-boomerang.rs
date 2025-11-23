impl Solution {
    pub fn is_boomerang(points: Vec<Vec<i32>>) -> bool {
        let x1 = points[0][0];
        let y1 = points[0][1];
        let x2 = points[1][0];
        let y2 = points[1][1];
        let x3 = points[2][0];
        let y3 = points[2][1];

        // Check if any two points are identical. If so, they are not distinct.
        if (x1 == x2 && y1 == y2) || (x1 == x3 && y1 == y3) || (x2 == x3 && y2 == y3) {
            return false;
        }

        // Check for collinearity using the determinant formula for 2 * Area.
        // If the expression is zero, the points are collinear.
        let area_double = x1 * (y2 - y3) + x2 * (y3 - y1) + x3 * (y1 - y2);
        if area_double == 0 {
            return false;
        }

        // If all points are distinct and not collinear, it's a boomerang.
        true
    }
}