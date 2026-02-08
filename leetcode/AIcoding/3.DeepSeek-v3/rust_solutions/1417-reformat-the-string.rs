impl Solution {
    pub fn reformat(s: String) -> String {
        let mut digits = Vec::new();
        let mut letters = Vec::new();

        for c in s.chars() {
            if c.is_ascii_digit() {
                digits.push(c);
            } else {
                letters.push(c);
            }
        }

        let diff = digits.len() as i32 - letters.len() as i32;
        if diff.abs() > 1 {
            return String::new();
        }

        let mut res = String::new();
        let (longer, shorter) = if digits.len() > letters.len() {
            (&digits, &letters)
        } else {
            (&letters, &digits)
        };

        for i in 0..shorter.len() {
            res.push(longer[i]);
            res.push(shorter[i]);
        }

        if longer.len() > shorter.len() {
            res.push(*longer.last().unwrap());
        }

        res
    }
}