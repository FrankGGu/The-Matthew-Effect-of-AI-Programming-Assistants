impl Solution {
    pub fn min_rectangles_to_cover_points(points: Vec<Vec<i32>>, w: i32) -> i32 {
        let mut x_coords: Vec<i32> = points.into_iter().map(|p| p[0]).collect();
        x_coords.sort_unstable();

        let mut rectangles_count = 0;
        let mut i = 0;
        let n = x_coords.len();

        while i < n {
            rectangles_count += 1;
            let current_x = x_coords[i];
            let cover_limit = current_x + w;

            let mut j = i;
            while j < n && x_coords[j] <= cover_limit {
                j += 1;
            }
            i = j;
        }

        rectangles_count
    }
}