impl Solution {
    pub fn winner_of_game(colors: String) -> bool {
        let mut a_count = 0;
        let mut b_count = 0;
        let chars: Vec<char> = colors.chars().collect();

        for i in 1..chars.len() - 1 {
            if chars[i - 1] == chars[i] && chars[i] == chars[i + 1] {
                if chars[i] == 'A' {
                    a_count += 1;
                } else {
                    b_count += 1;
                }
            }
        }

        a_count > b_count
    }
}