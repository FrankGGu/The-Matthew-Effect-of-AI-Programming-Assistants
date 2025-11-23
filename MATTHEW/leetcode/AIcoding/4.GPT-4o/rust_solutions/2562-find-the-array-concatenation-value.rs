impl Solution {
    pub fn find_array_conc_val(arr: Vec<i32>) -> i64 {
        let n = arr.len();
        let mut sum = 0;
        for i in 0..(n / 2) {
            sum += (arr[i] as i64) * 10i64.pow((arr[n - i - 1] as f64).log(10.0).ceil() as u32) + arr[n - i - 1] as i64;
        }
        if n % 2 == 1 {
            sum += arr[n / 2] as i64;
        }
        sum
    }
}