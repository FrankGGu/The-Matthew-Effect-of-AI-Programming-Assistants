impl Solution {
    pub fn sum_odd_length_subarrays(arr: Vec<i32>) -> i32 {
        let n = arr.len();
        let mut total_sum = 0;

        for i in 0..n {
            // Number of possible starting points for a subarray that includes arr[i]
            // (from index 0 to i, inclusive)
            let count_left = i + 1; 

            // Number of possible ending points for a subarray that includes arr[i]
            // (from index i to n-1, inclusive)
            let count_right = n - i; 

            // The number of odd-length subarrays that contain arr[i]
            // This formula is derived from counting pairs (start_idx, end_idx)
            // such that start_idx <= i <= end_idx and (end_idx - start_idx + 1) is odd.
            // It simplifies to (count_left * count_right + 1) / 2 using integer division.
            let num_odd_subarrays_for_i = (count_left * count_right + 1) / 2;

            total_sum += arr[i] * (num_odd_subarrays_for_i as i32);
        }

        total_sum
    }
}