impl Solution {
    pub fn unique_letter_string(s: String) -> i32 {
        let n = s.len();
        let s_bytes = s.as_bytes();
        let mut left = vec![-1; n];
        let mut right = vec![n as i32; n];
        let mut last_pos = [-1; 26];

        for i in 0..n {
            let c = (s_bytes[i] - b'A') as usize;
            left[i] = last_pos[c];
            last_pos[c] = i as i32;
        }

        last_pos = [-1; 26];

        for i in (0..n).rev() {
            let c = (s_bytes[i] - b'A') as usize;
            right[i] = last_pos[c];
            last_pos[c] = i as i32;
        }

        let mut ans = 0;
        for i in 0..n {
            ans += (i as i32 - left[i]) * (right[i] - i as i32);
        }

        ans
    }
}