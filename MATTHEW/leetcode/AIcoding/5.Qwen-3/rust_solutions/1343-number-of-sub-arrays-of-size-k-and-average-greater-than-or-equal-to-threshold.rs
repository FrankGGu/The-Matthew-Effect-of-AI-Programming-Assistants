struct Solution;

impl Solution {
    pub fn subarray_avg(k: i32, threshold: i32, arr: Vec<i32>) -> i32 {
        let k = k as usize;
        let n = arr.len();
        let mut sum = 0;
        let mut count = 0;

        for i in 0..k {
            sum += arr[i];
        }

        if sum as f64 / k as f64 >= threshold as f64 {
            count += 1;
        }

        for i in k..n {
            sum += arr[i] - arr[i - k];
            if sum as f64 / k as f64 >= threshold as f64 {
                count += 1;
            }
        }

        count
    }
}