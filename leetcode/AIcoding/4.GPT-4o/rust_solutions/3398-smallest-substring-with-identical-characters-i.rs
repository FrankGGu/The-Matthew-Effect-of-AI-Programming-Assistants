impl Solution {
    pub fn minimum_length(s: String) -> i32 {
        let bytes = s.as_bytes();
        let n = bytes.len();
        let mut left = 0;
        let mut right = n - 1;

        while left < n && bytes[left] == bytes[0] {
            left += 1;
        }
        while right > left && bytes[right] == bytes[n - 1] {
            right -= 1;
        }

        if left > right {
            return 0;
        }

        (right - left + 1) as i32
    }
}