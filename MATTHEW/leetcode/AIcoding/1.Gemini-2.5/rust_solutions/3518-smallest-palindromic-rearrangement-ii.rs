impl Solution {
    pub fn smallest_palindromic_rearrangement_ii(s: String) -> String {
        let mut counts = [0; 26];
        for c in s.chars() {
            counts[(c as u8 - b'a') as usize] += 1;
        }

        let mut odd_char: Option<char> = None;
        let mut odd_count_chars = 0;

        for i in 0..26 {
            if counts[i] % 2 == 1 {
                odd_count_chars += 1;
                odd_char = Some((b'a' + i as u8) as char);
            }
        }

        if odd_count_chars > 1 {
            return String::new();
        }

        let mut first_half = String::new();
        for i in 0..26 {
            let char_code = (b'a' + i as u8) as char;
            for _ in 0..(counts[i] / 2) {
                first_half.push(char_code);
            }
        }

        let mut result = first_half.clone();
        if let Some(c) = odd_char {
            result.push(c);
        }

        let reversed_first_half: String = first_half.chars().rev().collect();
        result.push_str(&reversed_first_half);

        result
    }
}