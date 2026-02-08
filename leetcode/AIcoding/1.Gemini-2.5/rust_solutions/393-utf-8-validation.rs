impl Solution {
    pub fn valid_utf8(data: Vec<i32>) -> bool {
        let mut bytes_to_follow = 0;

        for &byte_i32 in data.iter() {
            let byte = byte_i32 as u8;

            if bytes_to_follow == 0 {
                if (byte & 0x80) == 0x00 { // 0xxxxxxx
                    // 1-byte character, bytes_to_follow remains 0
                } else if (byte & 0xE0) == 0xC0 { // 110xxxxx
                    bytes_to_follow = 1;
                } else if (byte & 0xF0) == 0xE0 { // 1110xxxx
                    bytes_to_follow = 2;
                } else if (byte & 0xF8) == 0xF0 { // 11110xxx
                    bytes_to_follow = 3;
                } else {
                    return false; // Invalid leading byte pattern
                }
            } else {
                if (byte & 0xC0) == 0x80 { // Must be 10xxxxxx
                    bytes_to_follow -= 1;
                } else {
                    return false; // Invalid continuation byte pattern
                }
            }
        }

        bytes_to_follow == 0
    }
}