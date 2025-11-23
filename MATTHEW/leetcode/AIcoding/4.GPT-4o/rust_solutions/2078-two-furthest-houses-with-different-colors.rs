pub fn max_distance(colors: Vec<i32>) -> i32 {
    let n = colors.len();
    let first_color = colors[0];
    let last_color = colors[n - 1];

    let mut max_distance = 0;

    for i in 0..n {
        if colors[i] != first_color {
            max_distance = max_distance.max(i as i32);
        }
        if colors[i] != last_color {
            max_distance = max_distance.max((n - 1 - i) as i32);
        }
    }

    max_distance
}