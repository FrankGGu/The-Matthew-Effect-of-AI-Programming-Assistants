impl Solution {
    pub fn shortest_to_char(s: String, c: char) -> Vec<i32> {
        let n = s.len();
        let mut res = vec![i32::MAX; n];
        let mut prev = i32::MAX;

        for i in 0..n {
            if s.chars().nth(i).unwrap() == c {
                prev = i as i32;
            }
            res[i] = prev;
        }

        prev = i32::MAX;
        for i in (0..n).rev() {
            if s.chars().nth(i).unwrap() == c {
                prev = i as i32;
            }
            res[i] = res[i].min((prev - i as i32).abs());
        }

        res
    }
}