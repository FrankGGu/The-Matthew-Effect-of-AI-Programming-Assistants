impl Solution {
    pub fn to_hex(num: i32) -> String {
        if num == 0 {
            return "0".to_string();
        }
        let mut num = num as u32;
        let mut res = String::new();
        let hex_chars = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f'];
        while num != 0 {
            let digit = (num & 0xf) as usize;
            res.push(hex_chars[digit]);
            num >>= 4;
        }
        res.chars().rev().collect()
    }
}