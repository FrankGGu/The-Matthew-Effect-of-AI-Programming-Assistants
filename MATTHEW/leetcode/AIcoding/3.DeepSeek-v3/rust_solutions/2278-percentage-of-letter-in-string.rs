impl Solution {
    pub fn percentage_letter(s: String, letter: char) -> i32 {
        let count = s.chars().filter(|&c| c == letter).count();
        (count * 100 / s.len()) as i32
    }
}