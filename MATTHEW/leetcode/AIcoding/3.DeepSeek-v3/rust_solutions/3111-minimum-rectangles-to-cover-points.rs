impl Solution {
    pub fn min_rectangles_to_cover_points(points: Vec<Vec<i32>>, w: i32) -> i32 {
        let mut x_coords: Vec<i32> = points.into_iter().map(|p| p[0]).collect();
        x_coords.sort_unstable();
        let mut res = 0;
        let mut i = 0;
        let n = x_coords.len();
        while i < n {
            let start = x_coords[i];
            let end = start + w;
            res += 1;
            while i < n && x_coords[i] <= end {
                i += 1;
            }
        }
        res
    }
}