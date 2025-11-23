impl Solution {
    pub fn sum_odd_length_subarrays(arr: Vec<i32>) -> i32 {
        let n = arr.len();
        let mut sum = 0;
        for len in (1..=n).step_by(2) {
            for i in 0..=(n - len) {
                for j in i..(i + len) {
                    sum += arr[j];
                }
            }
        }
        sum
    }
}