impl Solution {
    pub fn is_boomerang(points: Vec<Vec<i32>>) -> bool {
        return (points[1][1] - points[0][1]) * (points[2][0] - points[1][0]) != (points[2][1] - points[1][1]) * (points[1][0] - points[0][0]);
    }
}