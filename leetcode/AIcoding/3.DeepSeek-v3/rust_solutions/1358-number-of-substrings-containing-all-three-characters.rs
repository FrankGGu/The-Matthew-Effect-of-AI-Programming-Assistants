impl Solution {
    pub fn number_of_substrings(s: String) -> i32 {
        let s = s.as_bytes();
        let mut count = [0; 3];
        let mut res = 0;
        let mut left = 0;

        for right in 0..s.len() {
            count[(s[right] - b'a') as usize] += 1;

            while count[0] > 0 && count[1] > 0 && count[2] > 0 {
                res += s.len() - right;
                count[(s[left] - b'a') as usize] -= 1;
                left += 1;
            }
        }

        res as i32
    }
}