impl Solution {
    pub fn longest_mountain(arr: Vec<i32>) -> i32 {
        let n = arr.len();
        if n < 3 { return 0; }
        let mut longest = 0;

        let mut i = 1;
        while i < n - 1 {
            if arr[i - 1] < arr[i] && arr[i] > arr[i + 1] {
                let mut left = i;
                let mut right = i;

                while left > 0 && arr[left - 1] < arr[left] {
                    left -= 1;
                }

                while right < n - 1 && arr[right] > arr[right + 1] {
                    right += 1;
                }

                longest = longest.max((right - left + 1) as i32);
                i = right;
            } else {
                i += 1;
            }
        }

        longest
    }
}