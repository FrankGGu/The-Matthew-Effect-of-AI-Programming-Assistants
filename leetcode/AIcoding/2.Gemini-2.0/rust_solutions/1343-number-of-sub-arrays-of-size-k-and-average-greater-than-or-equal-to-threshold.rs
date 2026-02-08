impl Solution {
    pub fn num_of_subarrays(arr: Vec<i32>, k: i32, threshold: i32) -> i32 {
        let mut count = 0;
        let mut sum = 0;
        for i in 0..arr.len() {
            sum += arr[i];
            if i >= k as usize - 1 {
                if sum as f64 / k as f64 >= threshold as f64 {
                    count += 1;
                }
                sum -= arr[i - k as usize + 1];
            }
        }
        count
    }
}