pub struct Solution;

impl Solution {
    pub fn check_overlap(circle: Vec<i32>, rectangle: Vec<i32>) -> bool {
        let (cx, cy, r) = (circle[0], circle[1], circle[2]);
        let (rx1, ry1, rx2, ry2) = (rectangle[0], rectangle[1], rectangle[2], rectangle[3]);

        let closest_x = cx.max(rx1).min(rx2);
        let closest_y = cy.max(ry1).min(ry2);

        let distance_x = cx - closest_x;
        let distance_y = cy - closest_y;

        distance_x * distance_x + distance_y * distance_y <= r * r
    }
}