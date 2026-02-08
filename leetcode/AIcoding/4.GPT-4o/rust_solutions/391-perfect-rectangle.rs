use std::collections::HashMap;

pub fn is_rectangle_cover(rectangles: Vec<Vec<i32>>) -> bool {
    let mut corners = HashMap::new();
    let mut area = 0;
    let mut min_x = i32::MAX;
    let mut min_y = i32::MAX;
    let mut max_x = i32::MIN;
    let mut max_y = i32::MIN;

    for rect in &rectangles {
        let (x1, y1, x2, y2) = (rect[0], rect[1], rect[2], rect[3]);
        area += (x2 - x1) * (y2 - y1);

        min_x = min_x.min(x1);
        min_y = min_y.min(y1);
        max_x = max_x.max(x2);
        max_y = max_y.max(y2);

        *corners.entry((x1, y1)).or_insert(0) += 1;
        *corners.entry((x1, y2)).or_insert(0) += 1;
        *corners.entry((x2, y1)).or_insert(0) += 1;
        *corners.entry((x2, y2)).or_insert(0) += 1;
    }

    let expected_area = (max_x - min_x) * (max_y - min_y);
    if area != expected_area {
        return false;
    }

    let mut corner_count = 0;
    for &count in corners.values() {
        if count % 2 == 1 {
            corner_count += 1;
        }
    }

    corner_count == 4
}