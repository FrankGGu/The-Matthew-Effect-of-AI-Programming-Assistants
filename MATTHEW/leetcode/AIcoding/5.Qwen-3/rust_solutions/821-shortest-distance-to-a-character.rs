struct Solution;

impl Solution {
    pub fn shortest_distance(s: String, c: char) -> Vec<i32> {
        let n = s.len();
        let mut result = vec![n as i32; n];
        let mut last = -n as i32;

        for i in 0..n {
            if s.as_bytes()[i] == c as u8 {
                last = i as i32;
            }
            result[i] = (i as i32 - last).abs();
        }

        for i in (0..n).rev() {
            if s.as_bytes()[i] == c as u8 {
                last = i as i32;
            }
            result[i] = result[i].min((i as i32 - last).abs());
        }

        result
    }
}