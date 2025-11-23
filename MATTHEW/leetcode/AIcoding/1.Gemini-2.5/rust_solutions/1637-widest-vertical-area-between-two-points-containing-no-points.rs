impl Solution {
    pub fn max_width_of_vertical_area(points: Vec<Vec<i32>>) -> i32 {
        let mut x_coords: Vec<i32> = points.iter().map(|p| p[0]).collect();
        x_coords.sort_unstable();

        let mut max_diff = 0;
        for i in 0..x_coords.len() - 1 {
            max_diff = max_diff.max(x_coords[i + 1] - x_coords[i]);
        }
        max_diff
    }
}