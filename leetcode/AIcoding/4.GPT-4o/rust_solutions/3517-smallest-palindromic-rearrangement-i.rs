impl Solution {
    pub fn smallest_palindrome(s: String) -> String {
        let mut count = [0; 26];
        for byte in s.bytes() {
            count[(byte - b'a') as usize] += 1;
        }

        let mut half = String::new();
        let mut middle = String::new();

        for i in 0..26 {
            if count[i] % 2 == 1 {
                middle = (b'a' + i as u8) as char.to_string();
            }
            half.push_str(&((b'a' + i as u8) as char).to_string().repeat(count[i] / 2));
        }

        if half.is_empty() && middle.is_empty() {
            return String::new();
        }

        let pal = half.clone() + &middle + &half.chars().rev().collect::<String>();
        pal
    }
}