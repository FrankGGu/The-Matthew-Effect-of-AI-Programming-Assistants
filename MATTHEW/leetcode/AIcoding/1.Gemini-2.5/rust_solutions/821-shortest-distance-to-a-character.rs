impl Solution {
    pub fn shortest_to_char(s: String, c: char) -> Vec<i32> {
        let n = s.len();
        let s_chars: Vec<char> = s.chars().collect();
        let mut ans = vec![0; n];

        let mut prev_c_idx = -n as i32;
        for i in 0..n {
            if s_chars[i] == c {
                prev_c_idx = i as i32;
            }
            ans[i] = (i as i32) - prev_c_idx;
        }

        let mut next_c_idx = 2 * n as i32;
        for i in (0..n).rev() {
            if s_chars[i] == c {
                next_c_idx = i as i32;
            }
            ans[i] = ans[i].min(next_c_idx - (i as i32));
        }

        ans
    }
}