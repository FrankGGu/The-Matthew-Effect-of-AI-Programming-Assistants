use std::cmp::max;

impl Solution {
    pub fn maximum_area(points: Vec<Vec<i32>>, k: i32) -> i64 {
        let n = points.len();
        let k = k as usize;

        // Sort points by x-coordinate. This allows us to iterate through potential left and right
        // boundaries of the rectangle efficiently using a sweep-line approach.
        let mut sorted_points = points;
        sorted_points.sort_unstable_by_key(|p| p[0]);

        let mut max_area: i64 = 0;

        // Iterate through all possible left boundaries (x_left) of the rectangle.
        // The x_left coordinate will be determined by the x-coordinate of a point.
        for i in 0..n {
            let x_left = sorted_points[i][0];

            // `active_y_coords` will store the y-coordinates of points that are currently
            // within the vertical strip defined by `x_left` and the current `x_right`.
            // This vector is kept sorted to efficiently find the k points with the minimum
            // height difference (y_top - y_bottom).
            let mut active_y_coords: Vec<i32> = Vec::new();

            // Iterate through all possible right boundaries (x_right) of the rectangle,
            // starting from the current x_left point.
            // The x_right coordinate will be determined by the x-coordinate of a point.
            for j in i..n {
                let x_right = sorted_points[j][0];
                let current_point_y = sorted_points[j][1];

                // Insert the y-coordinate of the current point into `active_y_coords`
                // while maintaining its sorted order.
                // `binary_search` returns `Ok(index)` if the element is found, or
                // `Err(insert_index)` if not found, indicating where it would be inserted.
                let insert_idx = active_y_coords.binary_search(&current_point_y).unwrap_or_else(|e| e);
                active_y_coords.insert(insert_idx, current_point_y);

                // If the number of points in the current vertical strip is less than k,
                // we cannot form a rectangle containing at least k points yet.
                // Continue to the next x_right.
                if active_y_coords.len() < k {
                    continue;
                }

                // Calculate the current width of the rectangle.
                let current_width = (x_right - x_left) as i64;

                // Use a sliding window of size k on the sorted `active_y_coords`
                // to find the minimum possible height (y_top - y_bottom) that
                // encloses k points.
                // The window slides from the first k points to the last k points.
                for window_start_idx in 0..=active_y_coords.len() - k {
                    let y_bottom = active_y_coords[window_start_idx];
                    let y_top = active_y_coords[window_start_idx + k - 1];

                    let current_height = (y_top - y_bottom) as i64;

                    // Calculate the area of the current rectangle.
                    let current_area = current_width * current_height;

                    // Update the maximum area found so far.
                    max_area = max(max_area, current_area);
                }
            }
        }

        max_area
    }
}