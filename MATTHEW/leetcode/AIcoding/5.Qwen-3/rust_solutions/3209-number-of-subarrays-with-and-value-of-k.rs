struct Solution;

impl Solution {
    pub fn num_subarrays(arr: Vec<i32>, k: i32) -> i32 {
        let mut count = 0;
        let mut current_and = 0;
        let mut left = 0;

        for right in 0..arr.len() {
            current_and &= arr[right];

            while left <= right && current_and < k {
                current_and |= arr[left];
                left += 1;
            }

            if current_and == k {
                count += 1;
            }
        }

        count
    }
}