pub fn trim_mean(arr: Vec<i32>) -> f64 {
    let mut sorted_arr = arr.clone();
    sorted_arr.sort();
    let n = sorted_arr.len();
    let trim_count = n / 20;
    let trimmed_sum: i32 = sorted_arr[trim_count..(n - trim_count)].iter().sum();
    trimmed_sum as f64 / (n - 2 * trim_count) as f64
}