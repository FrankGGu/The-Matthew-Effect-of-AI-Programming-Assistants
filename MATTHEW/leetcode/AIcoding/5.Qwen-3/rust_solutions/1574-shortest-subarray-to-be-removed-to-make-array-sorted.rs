struct Solution;

impl Solution {
    pub fn find_length_of_shortest_subarray(arr: Vec<i32>) -> i32 {
        let n = arr.len();
        let mut left = 0;
        while left + 1 < n && arr[left] <= arr[left + 1] {
            left += 1;
        }
        if left == n - 1 {
            return 0;
        }
        let mut right = n - 1;
        while right > 0 && arr[right - 1] <= arr[right] {
            right -= 1;
        }
        let mut result = std::cmp::min(n - left - 1, right);
        let mut i = 0;
        let mut j = right;
        while i <= left && j < n {
            if arr[i] <= arr[j] {
                result = std::cmp::min(result, j - i - 1);
                i += 1;
            } else {
                j += 1;
            }
        }
        result as i32
    }
}