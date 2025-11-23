impl Solution {
    pub fn percentage_letter(s: String, letter: char) -> i32 {
        let count = s.chars().filter(|&c| c == letter).count();
        ((count as f64 / s.len() as f64) * 100.0).round() as i32
    }
}