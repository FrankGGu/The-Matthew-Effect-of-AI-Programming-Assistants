impl Solution {
    pub fn unique_letter_string(s: String) -> i32 {
        let mut last_pos = vec![vec![]; 26];
        for (i, c) in s.chars().enumerate() {
            let idx = (c as u8 - b'A') as usize;
            last_pos[idx].push(i as i32);
        }

        let mut res = 0;
        for positions in last_pos.iter() {
            let mut prev = -1;
            for i in 0..positions.len() {
                let curr = positions[i];
                let next = if i + 1 < positions.len() {
                    positions[i + 1]
                } else {
                    s.len() as i32
                };
                res += (curr - prev) * (next - curr);
                prev = curr;
            }
        }
        res
    }
}