impl Solution {
    pub fn valid_utf8(data: Vec<i32>) -> bool {
        let mut i = 0;
        while i < data.len() {
            let num = data[i] as u8;
            let mut bytes = 0;
            if num >> 7 == 0 {
                bytes = 1;
            } else if num >> 5 == 0b110 {
                bytes = 2;
            } else if num >> 4 == 0b1110 {
                bytes = 3;
            } else if num >> 3 == 0b11110 {
                bytes = 4;
            } else {
                return false;
            }

            if i + bytes > data.len() {
                return false;
            }

            for j in 1..bytes {
                if data[i + j] as u8 >> 6 != 0b10 {
                    return false;
                }
            }

            i += bytes;
        }
        true
    }
}