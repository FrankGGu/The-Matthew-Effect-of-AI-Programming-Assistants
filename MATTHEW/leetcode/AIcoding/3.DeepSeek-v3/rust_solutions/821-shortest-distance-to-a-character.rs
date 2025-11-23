impl Solution {
    pub fn shortest_to_char(s: String, c: char) -> Vec<i32> {
        let s = s.as_bytes();
        let n = s.len();
        let mut res = vec![i32::MAX; n];
        let mut prev = i32::MIN / 2;

        for i in 0..n {
            if s[i] == c as u8 {
                prev = i as i32;
            }
            res[i] = (i as i32 - prev).abs();
        }

        prev = i32::MAX / 2;
        for i in (0..n).rev() {
            if s[i] == c as u8 {
                prev = i as i32;
            }
            res[i] = res[i].min(prev - i as i32);
        }

        res
    }
}