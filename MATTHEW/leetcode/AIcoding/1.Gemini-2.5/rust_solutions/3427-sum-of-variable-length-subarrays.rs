impl Solution {
    pub fn sum_odd_length_subarrays(arr: Vec<i32>) -> i32 {
        let n = arr.len();
        let mut total_sum = 0;

        for i in 0..n {
            let left_count = (i + 1) as i32;
            let right_count = (n - i) as i32;

            // The total number of subarrays that contain arr[i]
            let num_subarrays_containing_i = left_count * right_count;

            // The number of odd-length subarrays that contain arr[i]
            // This is equivalent to ceil(num_subarrays_containing_i / 2.0)
            let num_odd_length_subarrays_containing_i = (num_subarrays_containing_i + 1) / 2;

            total_sum += arr[i] * num_odd_length_subarrays_containing_i;
        }

        total_sum
    }
}