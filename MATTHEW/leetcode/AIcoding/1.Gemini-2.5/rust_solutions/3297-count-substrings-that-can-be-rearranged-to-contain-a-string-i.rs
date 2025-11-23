impl Solution {
    pub fn count_substrings(s: String) -> i32 {
        let n = s.len();
        let s_bytes = s.as_bytes();
        let mut last_a: isize = -1;
        let mut last_b: isize = -1;
        let mut last_c: isize = -1;
        let mut count: i32 = 0;

        for j in 0..n {
            match s_bytes[j] {
                b'a' => last_a = j as isize,
                b'b' => last_b = j as isize,
                b'c' => last_c = j as isize,
                _ => {}
            }

            if last_a != -1 && last_b != -1 && last_c != -1 {
                let min_last = last_a.min(last_b).min(last_c);
                count += (min_last + 1) as i32;
            }
        }
        count
    }
}