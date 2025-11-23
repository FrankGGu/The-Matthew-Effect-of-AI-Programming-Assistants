impl Solution {
    pub fn to_hex(num: i32) -> String {
        if num == 0 {
            return "0".to_string();
        }

        let hex_chars: [char; 16] = [
            '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f',
        ];

        let mut unsigned_num = num as u32;
        let mut result_chars = Vec::new();

        while unsigned_num > 0 {
            let digit_val = (unsigned_num & 0xF) as usize;
            result_chars.push(hex_chars[digit_val]);
            unsigned_num >>= 4;
        }

        result_chars.into_iter().rev().collect()
    }
}