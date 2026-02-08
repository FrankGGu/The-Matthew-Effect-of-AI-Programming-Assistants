impl Solution {
    pub fn can_convert_string(s: String, t: String, k: i32) -> bool {
        if s.len() != t.len() {
            return false;
        }
        let s_bytes = s.as_bytes();
        let t_bytes = t.as_bytes();
        let mut shifts = vec![0; 26];

        for i in 0..s_bytes.len() {
            let diff = (t_bytes[i] as i32 - s_bytes[i] as i32 + 26) % 26;
            if diff != 0 {
                shifts[diff as usize] += 1;
            }
        }

        for i in 1..26 {
            let max_possible = (k - i as i32) / 26 + 1;
            if shifts[i] > max_possible {
                return false;
            }
        }

        true
    }
}