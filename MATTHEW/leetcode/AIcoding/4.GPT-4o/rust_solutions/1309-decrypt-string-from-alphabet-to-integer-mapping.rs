impl Solution {
    pub fn freq_alphabets(s: String) -> String {
        let mut result = String::new();
        let mut i = 0;
        let chars: Vec<char> = s.chars().collect();

        while i < chars.len() {
            if i + 2 < chars.len() && chars[i + 2] == '#' {
                let num = &s[i..i + 2];
                result.push(('a' as u8 + num.parse::<u8>().unwrap() - 1) as char);
                i += 3;
            } else {
                let num = chars[i].to_digit(10).unwrap();
                result.push(('a' as u8 + num as u8 - 1) as char);
                i += 1;
            }
        }

        result
    }
}