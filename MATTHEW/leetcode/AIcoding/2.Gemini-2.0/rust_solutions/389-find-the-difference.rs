impl Solution {
    pub fn find_the_difference(s: String, t: String) -> char {
        let mut s_sum: i32 = 0;
        let mut t_sum: i32 = 0;

        for c in s.chars() {
            s_sum += c as i32;
        }

        for c in t.chars() {
            t_sum += c as i32;
        }

        (t_sum - s_sum) as u8 as char
    }
}