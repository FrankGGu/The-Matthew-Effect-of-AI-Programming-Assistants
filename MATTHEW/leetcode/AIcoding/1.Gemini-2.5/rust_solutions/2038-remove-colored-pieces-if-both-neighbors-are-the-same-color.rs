impl Solution {
    pub fn winner_of_game(colors: String) -> bool {
        let n = colors.len();
        if n < 3 {
            return false;
        }

        let chars: Vec<char> = colors.chars().collect();
        let mut alice_moves = 0;
        let mut bob_moves = 0;

        for i in 1..n - 1 {
            if chars[i] == 'A' && chars[i - 1] == 'A' && chars[i + 1] == 'A' {
                alice_moves += 1;
            } else if chars[i] == 'B' && chars[i - 1] == 'B' && chars[i + 1] == 'B' {
                bob_moves += 1;
            }
        }

        alice_moves > bob_moves
    }
}