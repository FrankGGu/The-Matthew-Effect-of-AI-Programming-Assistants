pub fn min_operations(boxes: String) -> Vec<i32> {
    let n = boxes.len();
    let mut result = vec![0; n];
    let mut left_count = 0;
    let mut right_count = 0;

    for i in 1..n {
        if boxes.as_bytes()[i-1] == b'1' {
            left_count += 1;
        }
        result[i] = result[i-1] + left_count;
    }

    for i in (0..n-1).rev() {
        if boxes.as_bytes()[i+1] == b'1' {
            right_count += 1;
        }
        result[i] += result[i+1] + right_count;
    }

    result
}