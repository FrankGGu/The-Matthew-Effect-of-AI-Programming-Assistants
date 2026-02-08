impl Solution {
    pub fn repeat_limited_string(s: String, repeat_limit: i32) -> String {
        let mut count = vec![0; 26];
        for ch in s.chars() {
            count[(ch as usize - 'a' as usize)] += 1;
        }

        let mut result = String::new();
        let mut last_char = '\0';
        let mut last_count = 0;

        while result.len() < s.len() {
            let mut found = false;
            for i in (0..26).rev() {
                if count[i] > 0 {
                    let ch = (i as u8 + b'a') as char;
                    if ch != last_char || last_count < repeat_limit {
                        result.push(ch);
                        count[i] -= 1;
                        last_char = ch;
                        last_count = 1;
                        found = true;
                        break;
                    } else if count[i] > 1 {
                        result.push(ch);
                        count[i] -= 2;
                        last_char = ch;
                        last_count = 2;
                        result.push(ch);
                        found = true;
                        break;
                    }
                }
            }
            if !found {
                break;
            }
        }

        result
    }
}