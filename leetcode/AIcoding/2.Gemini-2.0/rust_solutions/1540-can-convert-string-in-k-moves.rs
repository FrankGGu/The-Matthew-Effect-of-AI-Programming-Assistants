impl Solution {
    pub fn can_convert_string(s: String, t: String, k: i32) -> bool {
        if s.len() != t.len() {
            return false;
        }

        let n = s.len();
        let s_bytes = s.as_bytes();
        let t_bytes = t.as_bytes();

        let mut counts = vec![0; 26];

        for i in 0..n {
            let diff = (t_bytes[i] as i32 - s_bytes[i] as i32 + 26) % 26;

            if diff != 0 {
                counts[diff as usize] += 1;
            }
        }

        for i in 1..26 {
            if counts[i] > 0 {
                let max_moves = (counts[i] - 1) * 26 + i as i32;
                if max_moves > k {
                    return false;
                }
            }
        }

        true
    }
}