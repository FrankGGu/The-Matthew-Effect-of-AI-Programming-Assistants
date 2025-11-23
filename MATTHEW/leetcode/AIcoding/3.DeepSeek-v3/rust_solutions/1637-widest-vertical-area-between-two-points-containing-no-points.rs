impl Solution {
    pub fn max_width_of_vertical_area(points: Vec<Vec<i32>>) -> i32 {
        let mut xs: Vec<i32> = points.into_iter().map(|p| p[0]).collect();
        xs.sort_unstable();
        let mut max_width = 0;
        for i in 1..xs.len() {
            max_width = max_width.max(xs[i] - xs[i - 1]);
        }
        max_width
    }
}