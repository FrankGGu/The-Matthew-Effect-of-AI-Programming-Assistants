impl Solution {
    pub fn shortest_to_char(s: String, c: char) -> Vec<i32> {
        let n = s.len();
        let mut ans = vec![i32::MAX; n];
        let s_chars: Vec<char> = s.chars().collect();

        let mut last_pos = i32::MIN / 2;
        for i in 0..n {
            if s_chars[i] == c {
                last_pos = i as i32;
            }
            ans[i] = (i as i32 - last_pos).abs();
        }

        last_pos = i32::MAX / 2;
        for i in (0..n).rev() {
            if s_chars[i] == c {
                last_pos = i as i32;
            }
            ans[i] = ans[i].min((i as i32 - last_pos).abs());
        }

        ans
    }
}