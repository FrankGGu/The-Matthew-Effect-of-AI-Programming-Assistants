impl Solution {
    pub fn decode_message(key: String, message: String) -> String {
        let mut mapping: [char; 26] = ['\0'; 26];
        let mut current_target_char: char = 'a';

        for c in key.chars() {
            if c == ' ' {
                continue;
            }

            let idx = (c as u8 - b'a') as usize;
            if mapping[idx] == '\0' {
                mapping[idx] = current_target_char;
                current_target_char = (current_target_char as u8 + 1) as char;
                if current_target_char > 'z' {
                    break;
                }
            }
        }

        let mut decoded_message = String::with_capacity(message.len());
        for c in message.chars() {
            if c == ' ' {
                decoded_message.push(' ');
            } else {
                let idx = (c as u8 - b'a') as usize;
                decoded_message.push(mapping[idx]);
            }
        }

        decoded_message
    }
}