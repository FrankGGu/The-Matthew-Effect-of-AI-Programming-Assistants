impl Solution {
    pub fn append_characters(s: String, t: String) -> i32 {
        let mut s_iter = s.chars();
        let mut t_iter = t.chars();
        let mut s_char = s_iter.next();

        let mut t_char = t_iter.next();
        let mut count = 0;

        while t_char.is_some() {
            if s_char == t_char {
                t_char = t_iter.next();
            }
            s_char = s_iter.next();
            if s_char.is_none() {
                count += t_iter.count() + 1; // count remaining t's
                break;
            }
        }

        count
    }
}