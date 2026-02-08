impl Solution {
    pub fn longest_non_decreasing_subarray(arr1: Vec<i32>, arr2: Vec<i32>) -> Vec<i32> {
        let n = arr1.len();
        let mut max_len = 0;
        let mut start_index = 0;

        for i in 0..n {
            let mut length = 1;
            let mut j = i;

            while j + 1 < n && (arr1[j + 1] >= arr1[j] || arr2[j + 1] >= arr2[j]) {
                length += 1;
                j += 1;
            }

            if length > max_len {
                max_len = length;
                start_index = i;
            }
        }

        arr1[start_index..start_index + max_len].to_vec()
    }
}