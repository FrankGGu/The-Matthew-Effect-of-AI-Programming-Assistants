impl Solution {
    pub fn is_transformable(s: String, t: String) -> bool {
        let s: Vec<usize> = s.chars().map(|c| (c as u8 - b'0') as usize).collect();
        let t: Vec<usize> = t.chars().map(|c| (c as u8 - b'0') as usize).collect();

        let mut pos: Vec<Vec<usize>> = vec![Vec::new(); 10];
        for i in 0..s.len() {
            pos[s[i]].push(i);
        }

        let mut ptr: Vec<usize> = vec![0; 10];

        for &digit in &t {
            let found = if ptr[digit] < pos[digit].len() {
                pos[digit][ptr[digit]]
            } else {
                return false;
            };

            for i in 0..digit {
                if ptr[i] < pos[i].len() && pos[i][ptr[i]] < found {
                    return false;
                }
            }

            ptr[digit] += 1;
        }

        true
    }
}