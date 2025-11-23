pub fn min_area(rectangles: Vec<Vec<i32>>) -> i32 {
    let (mut x1, mut y1, mut x2, mut y2) = (i32::MAX, i32::MAX, i32::MIN, i32::MIN);

    for rect in rectangles {
        x1 = x1.min(rect[0]);
        y1 = y1.min(rect[1]);
        x2 = x2.max(rect[2]);
        y2 = y2.max(rect[3]);
    }

    ((x2 - x1) * (y2 - y1)) as i32
}