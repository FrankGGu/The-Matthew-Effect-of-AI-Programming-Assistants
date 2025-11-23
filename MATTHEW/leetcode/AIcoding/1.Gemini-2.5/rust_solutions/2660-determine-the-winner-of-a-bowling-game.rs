impl Solution {
    fn calculate_score(player_pins: Vec<i32>) -> i32 {
        let mut total_score = 0;
        let n = player_pins.len();

        for i in 0..n {
            let current_pins = player_pins[i];
            let mut multiplier = 1;

            if i >= 1 && player_pins[i - 1] == 10 {
                multiplier = 2;
            }
            if i >= 2 && player_pins[i - 2] == 10 {
                multiplier = 2;
            }

            total_score += current_pins * multiplier;
        }

        total_score
    }

    pub fn determine_winner(player1: Vec<i32>, player2: Vec<i32>) -> i32 {
        let score1 = Self::calculate_score(player1);
        let score2 = Self::calculate_score(player2);

        if score1 > score2 {
            1
        } else if score2 > score1 {
            2
        } else {
            0
        }
    }
}