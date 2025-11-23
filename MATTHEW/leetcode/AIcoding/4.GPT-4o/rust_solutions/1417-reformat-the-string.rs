impl Solution {
    pub fn reformat(s: String) -> String {
        let (mut letters, mut digits): (Vec<char>, Vec<char>) = s.chars().partition(|c| c.is_alphabetic());
        if (letters.len() as isize - digits.len() as isize).abs() > 1 {
            return String::new();
        }

        let (longer, shorter) = if letters.len() > digits.len() {
            (letters, digits)
        } else {
            (digits, letters)
        };

        let mut result = String::new();
        for i in 0..longer.len() {
            result.push(longer[i]);
            if i < shorter.len() {
                result.push(shorter[i]);
            }
        }
        result
    }
}