impl Solution {
    pub fn smallest_palindrome(s: String) -> String {
        let mut freq = vec![0; 26];
        for c in s.chars() {
            freq[(c as usize) - ('a' as usize)] += 1;
        }

        let mut half = String::new();
        let mut odd_char = None;

        for i in 0..26 {
            if freq[i] % 2 == 1 {
                if odd_char.is_none() {
                    odd_char = Some((i as u8 + b'a') as char);
                } else {
                    return String::new();
                }
            }
            half.push_str(&"".repeat(freq[i] / 2));
        }

        let mut half_chars: Vec<char> = half.chars().collect();
        half_chars.sort();
        let half = half_chars.into_iter().collect::<String>();

        if let Some(odd_char) = odd_char {
            return format!("{}{}{}", half, odd_char, half.chars().rev().collect::<String>());
        }

        format("{}{}", half, half.chars().rev().collect::<String>())
    }
}