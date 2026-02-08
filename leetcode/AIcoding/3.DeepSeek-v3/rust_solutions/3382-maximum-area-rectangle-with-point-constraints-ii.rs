use std::collections::HashSet;

impl Solution {
    pub fn max_area(rectangles: Vec<Vec<i32>>, points: Vec<Vec<i32>>) -> i64 {
        let mut unique_heights = HashSet::new();
        for rect in &rectangles {
            unique_heights.insert(rect[1]);
        }
        for point in &points {
            unique_heights.insert(point[1]);
        }
        let mut sorted_heights: Vec<i32> = unique_heights.into_iter().collect();
        sorted_heights.sort_unstable();

        let mut rects_by_height = vec![vec![]; sorted_heights.len()];
        for rect in rectangles {
            let h = rect[1];
            let pos = sorted_heights.binary_search(&h).unwrap();
            rects_by_height[pos].push((rect[0], rect[2]));
        }
        for rects in &mut rects_by_height {
            rects.sort_unstable();
        }

        let mut max_area = 0;
        let mut result = Vec::with_capacity(points.len());
        for point in points {
            let x = point[0];
            let y = point[1];
            let h_pos = match sorted_heights.binary_search(&y) {
                Ok(p) => p,
                Err(_) => {
                    result.push(0);
                    continue;
                }
            };
            let mut current_max = 0;
            for i in (0..=h_pos).rev() {
                let h = sorted_heights[i];
                let width = Self::find_max_width(&rects_by_height[i], x);
                if width > 0 {
                    let area = h as i64 * width as i64;
                    if area > current_max {
                        current_max = area;
                    }
                }
            }
            result.push(current_max);
            if current_max > max_area {
                max_area = current_max;
            }
        }

        result.into_iter().max().unwrap_or(0)
    }

    fn find_max_width(rects: &[(i32, i32)], x: i32) -> i32 {
        let mut left = 0;
        let mut right = rects.len() as i32 - 1;
        let mut best = 0;
        while left <= right {
            let mid = left + (right - left) / 2;
            if rects[mid as usize].0 <= x && rects[mid as usize].1 >= x {
                best = rects[mid as usize].1 - rects[mid as usize].0;
                left = mid + 1;
            } else if rects[mid as usize].0 > x {
                right = mid - 1;
            } else {
                left = mid + 1;
            }
        }
        best
    }
}