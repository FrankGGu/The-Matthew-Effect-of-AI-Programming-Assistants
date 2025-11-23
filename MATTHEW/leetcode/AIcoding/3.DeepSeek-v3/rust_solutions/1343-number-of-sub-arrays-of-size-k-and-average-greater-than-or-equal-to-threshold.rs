impl Solution {
    pub fn num_of_subarrays(arr: Vec<i32>, k: i32, threshold: i32) -> i32 {
        let k = k as usize;
        let threshold = threshold as i32 * k as i32;
        let mut sum = arr.iter().take(k).sum::<i32>();
        let mut count = if sum >= threshold { 1 } else { 0 };

        for i in k..arr.len() {
            sum += arr[i] - arr[i - k];
            if sum >= threshold {
                count += 1;
            }
        }

        count
    }
}