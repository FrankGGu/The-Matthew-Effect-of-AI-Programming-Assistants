impl Solution {
    pub fn minimum_length(s: String) -> i32 {
        let s = s.as_bytes();
        let mut left = 0;
        let mut right = s.len() - 1;

        while left < right && s[left] == s[right] {
            let c = s[left];
            while left <= right && s[left] == c {
                left += 1;
            }
            while left <= right && s[right] == c {
                right -= 1;
            }
        }

        (right as i32) - (left as i32) + 1
    }
}