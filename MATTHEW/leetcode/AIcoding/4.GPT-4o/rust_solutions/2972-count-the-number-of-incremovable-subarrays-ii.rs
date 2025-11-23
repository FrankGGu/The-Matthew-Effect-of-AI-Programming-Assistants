impl Solution {
    pub fn count_incremovable_subarrays(arr: Vec<i32>) -> i32 {
        let n = arr.len();
        let mut left = vec![0; n];
        let mut right = vec![0; n];

        for i in 1..n {
            if arr[i] >= arr[i - 1] {
                left[i] = left[i - 1] + 1;
            }
        }

        for i in (0..n - 1).rev() {
            if arr[i] <= arr[i + 1] {
                right[i] = right[i + 1] + 1;
            }
        }

        let mut total = n as i32;
        for i in 0..n {
            let l = left[i];
            let r = right[i];
            total += l * r;
        }

        total
    }
}