pub fn max_altitude(gain: Vec<i32>) -> i32 {
    let mut max_alt = 0;
    let mut current_alt = 0;

    for &g in &gain {
        current_alt += g;
        if current_alt > max_alt {
            max_alt = current_alt;
        }
    }

    max_alt
}