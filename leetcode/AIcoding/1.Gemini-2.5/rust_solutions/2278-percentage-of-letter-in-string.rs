impl Solution {
    pub fn percentage_of_letter(s: String, letter: char) -> i32 {
        let mut count = 0;
        let total_length = s.len() as i32;

        for c in s.chars() {
            if c == letter {
                count += 1;
            }
        }

        (count * 100) / total_length
    }
}