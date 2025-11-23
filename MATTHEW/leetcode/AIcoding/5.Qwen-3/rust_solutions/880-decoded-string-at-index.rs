impl Solution {
    pub fn decode_at_index(s: String, k: i32) -> String {
        let mut size = 0;
        let s_bytes = s.as_bytes();

        for &b in s_bytes {
            if b >= b'0' && b <= b'9' {
                size *= (b - b'0') as usize;
            } else {
                size += 1;
            }
        }

        for &b in s_bytes.iter().rev() {
            if b >= b'0' && b <= b'9' {
                let num = (b - b'0') as usize;
                size /= num;
                if k as usize > size {
                    k = k as usize % size;
                }
            } else {
                if k as usize == size {
                    return (b as char).to_string();
                }
                size -= 1;
            }
        }

        String::new()
    }
}