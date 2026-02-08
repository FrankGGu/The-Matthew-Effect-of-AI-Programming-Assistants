impl Solution {
    pub fn smallest_palindrome(s: String) -> String {
        let mut count = [0; 26];
        for c in s.chars() {
            count[(c as u8 - b'a') as usize] += 1;
        }

        let mut odd_char = None;
        for i in 0..26 {
            if count[i] % 2 != 0 {
                if odd_char.is_some() {
                    return "".to_string();
                }
                odd_char = Some((i as u8 + b'a') as char);
            }
        }

        let mut half = String::new();
        for i in 0..26 {
            let c = (i as u8 + b'a') as char;
            half.push_str(&c.to_string().repeat(count[i] / 2));
        }

        if let Some(c) = odd_char {
            half.push(c);
        }

        let mut res = half.clone();
        if let Some(c) = odd_char {
            half.pop();
        }
        for c in half.chars().rev() {
            res.push(c);
        }

        res
    }
}