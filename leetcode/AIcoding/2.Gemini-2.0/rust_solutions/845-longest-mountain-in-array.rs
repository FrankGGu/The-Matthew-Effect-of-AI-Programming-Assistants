impl Solution {
    pub fn longest_mountain(arr: Vec<i32>) -> i32 {
        let n = arr.len();
        if n < 3 {
            return 0;
        }

        let mut longest = 0;
        for i in 1..n - 1 {
            if arr[i] > arr[i - 1] && arr[i] > arr[i + 1] {
                let mut left = i - 1;
                while left > 0 && arr[left] > arr[left - 1] {
                    left -= 1;
                }

                let mut right = i + 1;
                while right < n - 1 && arr[right] > arr[right - 1] {
                    right += 1;
                }

                longest = longest.max((right - left + 1) as i32);
            }
        }

        longest
    }
}