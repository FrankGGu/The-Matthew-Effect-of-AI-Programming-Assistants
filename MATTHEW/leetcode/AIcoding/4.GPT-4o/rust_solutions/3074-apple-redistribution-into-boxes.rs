pub fn min_boxes(apple_count: Vec<i32>) -> i32 {
    let mut boxes = 0;
    let mut total_apples = 0;

    for &count in &apple_count {
        total_apples += count;
    }

    while total_apples > 0 {
        boxes += 1;
        total_apples -= boxes;
    }

    boxes
}