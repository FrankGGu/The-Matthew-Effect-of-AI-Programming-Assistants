impl Solution {
    pub fn winner_of_game(colors: String) -> bool {
        let colors: Vec<char> = colors.chars().collect();
        let n = colors.len();
        let mut alice_moves = 0;
        let mut bob_moves = 0;

        for i in 1..n - 1 {
            if colors[i] == colors[i - 1] && colors[i] == colors[i + 1] {
                if colors[i] == 'A' {
                    alice_moves += 1;
                } else {
                    bob_moves += 1;
                }
            }
        }

        alice_moves > bob_moves
    }
}