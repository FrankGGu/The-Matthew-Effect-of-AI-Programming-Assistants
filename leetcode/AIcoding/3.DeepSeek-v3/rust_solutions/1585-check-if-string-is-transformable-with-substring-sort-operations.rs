impl Solution {
    pub fn is_transformable(s: String, t: String) -> bool {
        let s_chars: Vec<char> = s.chars().collect();
        let t_chars: Vec<char> = t.chars().collect();
        let mut pos: Vec<Vec<usize>> = vec![Vec::new(); 10];

        for (i, &c) in s_chars.iter().enumerate() {
            let digit = c.to_digit(10).unwrap() as usize;
            pos[digit].push(i);
        }

        for (i, &c) in t_chars.iter().enumerate() {
            let digit = c.to_digit(10).unwrap() as usize;
            if pos[digit].is_empty() {
                return false;
            }
            let p = pos[digit][0];
            for d in 0..digit {
                if !pos[d].is_empty() && pos[d][0] < p {
                    return false;
                }
            }
            pos[digit].remove(0);
        }
        true
    }
}