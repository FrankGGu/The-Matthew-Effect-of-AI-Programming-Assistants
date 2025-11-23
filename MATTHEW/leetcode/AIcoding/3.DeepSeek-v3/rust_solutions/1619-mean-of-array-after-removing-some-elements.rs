impl Solution {
    pub fn trim_mean(arr: Vec<i32>) -> f64 {
        let mut arr = arr;
        arr.sort_unstable();
        let n = arr.len();
        let remove = n / 20;
        let sum: i32 = arr[remove..n - remove].iter().sum();
        sum as f64 / (n - 2 * remove) as f64
    }
}