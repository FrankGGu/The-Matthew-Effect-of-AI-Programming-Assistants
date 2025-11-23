pub fn arrange_balls(balls: Vec<i32>) -> Vec<i32> {
    let mut white_count = 0;
    for &ball in &balls {
        if ball == 0 {
            white_count += 1;
        }
    }
    let mut result = vec![0; balls.len()];
    for i in 0..white_count {
        result[i] = 0;
    }
    for i in white_count..balls.len() {
        result[i] = 1;
    }
    result
}