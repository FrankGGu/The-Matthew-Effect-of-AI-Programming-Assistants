impl Solution {
    pub fn sum_odd_length_subarrays(arr: Vec<i32>) -> i32 {
        let n = arr.len();
        let mut total_sum = 0;

        for i in 0..n {
            let odd_count = ((i + 1) * (n - i) + 1) / 2;
            total_sum += arr[i] * odd_count;
        }

        total_sum
    }
}