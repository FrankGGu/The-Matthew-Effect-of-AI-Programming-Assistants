impl Solution {
    pub fn is_boomerang(points: Vec<Vec<i32>>) -> bool {
        let (p1, p2, p3) = (&points[0], &points[1], &points[2]);
        let area = p1[0] * (p2[1] - p3[1]) + p2[0] * (p3[1] - p1[1]) + p3[0] * (p1[1] - p2[1]);
        area != 0 && p1 != p2 && p2 != p3 && p1 != p3
    }
}