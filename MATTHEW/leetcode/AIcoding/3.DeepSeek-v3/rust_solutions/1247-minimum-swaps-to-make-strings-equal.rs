impl Solution {
    pub fn minimum_swap(s1: String, s2: String) -> i32 {
        let (mut xy, mut yx) = (0, 0);
        let s1_chars: Vec<char> = s1.chars().collect();
        let s2_chars: Vec<char> = s2.chars().collect();

        for i in 0..s1.len() {
            if s1_chars[i] == 'x' && s2_chars[i] == 'y' {
                xy += 1;
            } else if s1_chars[i] == 'y' && s2_chars[i] == 'x' {
                yx += 1;
            }
        }

        if (xy + yx) % 2 != 0 {
            return -1;
        }

        xy / 2 + yx / 2 + (xy % 2) * 2
    }
}