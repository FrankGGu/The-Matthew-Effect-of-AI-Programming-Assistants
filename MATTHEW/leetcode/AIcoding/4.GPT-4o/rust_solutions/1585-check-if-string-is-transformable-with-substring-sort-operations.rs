impl Solution {
    pub fn is_transformable(s: String, t: String) -> bool {
        let mut s_chars: Vec<char> = s.chars().collect();
        let mut t_chars: Vec<char> = t.chars().collect();

        let mut index_map = vec![vec![]; 10];

        for (i, &ch) in s_chars.iter().enumerate() {
            index_map[(ch as u8 - b'0') as usize].push(i);
        }

        for &ch in t_chars.iter() {
            let digit = (ch as u8 - b'0') as usize;
            if index_map[digit].is_empty() {
                return false;
            }
            let pos = index_map[digit].remove(0);
            for j in 0..digit {
                if !index_map[j].is_empty() && index_map[j][0] < pos {
                    return false;
                }
            }
        }

        true
    }
}