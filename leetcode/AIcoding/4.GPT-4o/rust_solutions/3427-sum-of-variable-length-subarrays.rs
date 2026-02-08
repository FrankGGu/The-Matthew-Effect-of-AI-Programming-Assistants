impl Solution {
    pub fn sum_of_subarrays(arr: Vec<i32>) -> i32 {
        let n = arr.len();
        let mut total_sum = 0;

        for i in 0..n {
            total_sum += arr[i] * (i as i32 + 1) * (n as i32 - i as i32);
        }

        total_sum
    }
}