impl Solution {
    pub fn check_distances(s: String, distance: Vec<i32>) -> bool {
        let mut first_pos = vec![-1; 26];
        let s_chars: Vec<char> = s.chars().collect();

        for (i, &c) in s_chars.iter().enumerate() {
            let idx = (c as u8 - b'a') as usize;
            if first_pos[idx] == -1 {
                first_pos[idx] = i as i32;
            } else {
                let dist = (i as i32 - first_pos[idx] - 1) as i32;
                if dist != distance[idx] {
                    return false;
                }
            }
        }
        true
    }
}