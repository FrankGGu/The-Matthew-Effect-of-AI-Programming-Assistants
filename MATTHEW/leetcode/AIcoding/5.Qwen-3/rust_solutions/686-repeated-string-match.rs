struct Solution;

impl Solution {
    pub fn repeated_string_match(s: String, t: String) -> i32 {
        let mut s_repeated = String::new();
        let mut count = 0;

        while s_repeated.len() < t.len() {
            s_repeated.push_str(&s);
            count += 1;
            if s_repeated.contains(&t) {
                return count;
            }
        }

        s_repeated.push_str(&s);
        count += 1;

        if s_repeated.contains(&t) {
            count
        } else {
            -1
        }
    }
}