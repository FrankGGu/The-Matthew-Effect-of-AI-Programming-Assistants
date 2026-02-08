use std::collections::HashMap;

pub fn interchangeable_rectangles(rectangles: Vec<Vec<i32>>) -> i64 {
    let mut ratios = HashMap::new();
    let mut count = 0;

    for rect in rectangles {
        let (width, height) = (rect[0] as f64, rect[1] as f64);
        let ratio = (width / height).to_string();
        *ratios.entry(ratio).or_insert(0) += 1;
    }

    for &c in ratios.values() {
        if c > 1 {
            count += c * (c - 1) / 2;
        }
    }

    count
}