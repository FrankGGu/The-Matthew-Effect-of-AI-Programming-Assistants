pub fn min_boxes(mut boxes: Vec<i32>, target: i32) -> i32 {
    boxes.sort_unstable();
    let mut count = 0;
    let mut total = 0;

    for &b in boxes.iter().rev() {
        if total + b <= target {
            total += b;
            count += 1;
        }
        if total == target {
            return count;
        }
    }
    count
}