impl Solution {
    pub fn find_kth_positive(arr: Vec<i32>, k: i32) -> i32 {
        let mut left = 0;
        let mut right = arr.len();
        while left < right {
            let mid = left + (right - left) / 2;
            if arr[mid] - (mid as i32 + 1) < k {
                left = mid + 1;
            } else {
                right = mid;
            }
        }
        left as i32 + k
    }
}