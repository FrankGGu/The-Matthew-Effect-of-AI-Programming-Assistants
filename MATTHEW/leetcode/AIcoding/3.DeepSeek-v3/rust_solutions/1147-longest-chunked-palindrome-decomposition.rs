impl Solution {
    pub fn longest_decomposition(text: String) -> i32 {
        let s = text.as_bytes();
        let n = s.len();
        let mut res = 0;
        let mut left = 0;
        let mut right = n;

        while left < right {
            let mut found = false;
            for l in 1..=(right - left) / 2 {
                if s[left..left + l] == s[right - l..right] {
                    res += 2;
                    left += l;
                    right -= l;
                    found = true;
                    break;
                }
            }
            if !found {
                res += 1;
                break;
            }
        }

        res
    }
}