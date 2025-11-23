struct Solution;

impl Solution {
    pub fn is_valid_utf8(data: Vec<i32>) -> bool {
        let mut bytes = data.iter();
        while let Some(&b) = bytes.next() {
            if (b & 0x80) == 0 {
                continue;
            } else if (b & 0xE0) == 0xC0 {
                if bytes.next().is_none() || (bytes.next().unwrap() & 0xC0) != 0x80 {
                    return false;
                }
            } else if (b & 0xF0) == 0xE0 {
                for _ in 0..2 {
                    if bytes.next().is_none() || (bytes.next().unwrap() & 0xC0) != 0x80 {
                        return false;
                    }
                }
            } else if (b & 0xF8) == 0xF0 {
                for _ in 0..3 {
                    if bytes.next().is_none() || (bytes.next().unwrap() & 0xC0) != 0x80 {
                        return false;
                    }
                }
            } else {
                return false;
            }
        }
        true
    }
}