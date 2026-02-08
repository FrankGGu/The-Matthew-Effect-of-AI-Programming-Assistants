impl Solution {
    pub fn freq_alphabets(s: String) -> String {
        let mut res = String::new();
        let mut i = 0;
        let chars: Vec<char> = s.chars().collect();
        while i < chars.len() {
            if i + 2 < chars.len() && chars[i + 2] == '#' {
                let num = (chars[i].to_digit(10).unwrap() * 10 + chars[i + 1].to_digit(10).unwrap()) as u8;
                res.push((b'a' + num - 1) as char);
                i += 3;
            } else {
                let num = chars[i].to_digit(10).unwrap() as u8;
                res.push((b'a' + num - 1) as char);
                i += 1;
            }
        }
        res
    }
}