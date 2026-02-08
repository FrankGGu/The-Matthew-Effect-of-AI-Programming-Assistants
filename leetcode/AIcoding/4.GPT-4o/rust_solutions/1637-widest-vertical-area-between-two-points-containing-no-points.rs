impl Solution {
    pub fn max_width_of_vertical_area(points: Vec<Vec<i32>>) -> i32 {
        let mut x_coords: Vec<i32> = points.iter().map(|p| p[0]).collect();
        x_coords.sort_unstable();
        let mut max_width = 0;
        for i in 1..x_coords.len() {
            max_width = max_width.max(x_coords[i] - x_coords[i - 1]);
        }
        max_width
    }
}