use std::collections::HashMap;

impl Solution {
    pub fn count_rectangles(rectangles: Vec<Vec<i32>>, points: Vec<Vec<i32>>) -> Vec<i32> {
        let mut height_to_widths: HashMap<i32, Vec<i32>> = HashMap::new();
        for rect in &rectangles {
            let (l, h) = (rect[0], rect[1]);
            height_to_widths.entry(h).or_insert_with(Vec::new).push(l);
        }

        for widths in height_to_widths.values_mut() {
            widths.sort_unstable();
        }

        let mut res = Vec::with_capacity(points.len());
        for point in &points {
            let (x, y) = (point[0], point[1]);
            let mut count = 0;
            for (&h, widths) in &height_to_widths {
                if h >= y {
                    let idx = widths.partition_point(|&w| w < x);
                    count += widths.len() - idx;
                }
            }
            res.push(count as i32);
        }
        res
    }
}