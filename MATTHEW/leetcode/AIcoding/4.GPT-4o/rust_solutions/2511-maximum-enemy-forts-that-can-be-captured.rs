pub fn get_max_captured_forts(forts: Vec<i32>) -> i32 {
    let mut max_captured = 0;
    let n = forts.len();

    let mut last_fort = -1;
    for i in 0..n {
        if forts[i] != 0 {
            if last_fort != -1 && forts[i] != forts[last_fort] {
                max_captured = max_captured.max((i - last_fort - 1) as i32);
            }
            last_fort = i as i32;
        }
    }

    max_captured
}