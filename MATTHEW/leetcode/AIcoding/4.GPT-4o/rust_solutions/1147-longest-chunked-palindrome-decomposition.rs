impl Solution {
    pub fn longest_decomposition(text: String) -> i32 {
        let n = text.len();
        let bytes = text.as_bytes();
        let mut left = 0;
        let mut right = n;
        let mut count = 0;

        while left < right {
            let mut i = 1;
            while i <= (right - left) / 2 {
                if &bytes[left..left + i] == &bytes[right - i..right] {
                    count += 2;
                    left += i;
                    right -= i;
                    break;
                }
                i += 1;
            }
            if i > (right - left) / 2 {
                count += 1;
                break;
            }
        }
        count
    }
}