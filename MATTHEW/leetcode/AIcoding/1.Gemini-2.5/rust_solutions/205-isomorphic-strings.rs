struct Solution;

impl Solution {
    pub fn is_isomorphic(s: String, t: String) -> bool {
        if s.len() != t.len() {
            return false;
        }

        let mut s_to_t_map: [u8; 256] = [0; 256];
        let mut t_to_s_map: [u8; 256] = [0; 256];

        let s_bytes = s.as_bytes();
        let t_bytes = t.as_bytes();

        for i in 0..s.len() {
            let char_s_byte = s_bytes[i];
            let char_t_byte = t_bytes[i];

            if s_to_t_map[char_s_byte as usize] == 0 {
                s_to_t_map[char_s_byte as usize] = char_t_byte;
            } else if s_to_t_map[char_s_byte as usize] != char_t_byte {
                return false;
            }

            if t_to_s_map[char_t_byte as usize] == 0 {
                t_to_s_map[char_t_byte as usize] = char_s_byte;
            } else if t_to_s_map[char_t_byte as usize] != char_s_byte {
                return false;
            }
        }

        true
    }
}