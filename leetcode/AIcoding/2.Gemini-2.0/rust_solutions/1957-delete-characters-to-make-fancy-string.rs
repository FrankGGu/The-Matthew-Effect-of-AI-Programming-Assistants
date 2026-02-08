impl Solution {
    pub fn make_fancy_string(s: String) -> String {
        let mut res = String::new();
        let mut count = 0;
        let mut prev = ' ';

        for c in s.chars() {
            if c == prev {
                count += 1;
            } else {
                count = 1;
            }

            if count <= 2 {
                res.push(c);
            }

            prev = c;
        }

        res
    }
}