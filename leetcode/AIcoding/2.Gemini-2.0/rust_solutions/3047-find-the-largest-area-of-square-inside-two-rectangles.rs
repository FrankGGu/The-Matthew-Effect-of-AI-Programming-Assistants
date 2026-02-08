impl Solution {
    pub fn largest_area(bottom_left1: Vec<i32>, top_right1: Vec<i32>, bottom_left2: Vec<i32>, top_right2: Vec<i32>) -> i32 {
        let x_overlap = std::cmp::max(0, std::cmp::min(top_right1[0], top_right2[0]) - std::cmp::max(bottom_left1[0], bottom_left2[0]));
        let y_overlap = std::cmp::max(0, std::cmp::min(top_right1[1], top_right2[1]) - std::cmp::cmp::max(bottom_left1[1], bottom_left2[1]));

        let side = std::cmp::min(x_overlap, y_overlap);

        side * side
    }
}