impl Solution {
    pub fn trim_mean(arr: Vec<i32>) -> f64 {
        let n = arr.len();
        let trim_count = (n as f64 * 0.05) as usize;
        let mut sorted_arr = arr;
        sorted_arr.sort();
        let trimmed_arr = &sorted_arr[trim_count..n - trim_count];
        let sum: i32 = trimmed_arr.iter().sum();
        sum as f64 / (n - 2 * trim_count) as f64
    }
}