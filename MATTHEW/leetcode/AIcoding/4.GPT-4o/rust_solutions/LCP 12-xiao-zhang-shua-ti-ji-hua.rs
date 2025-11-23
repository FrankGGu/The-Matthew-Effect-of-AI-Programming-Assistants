pub fn can_complete(total: i32, k: i32, a: Vec<i32>) -> bool {
    let mut total_time = 0;
    for &x in &a {
        total_time += (x + k - 1) / k;
    }
    total_time <= total
}