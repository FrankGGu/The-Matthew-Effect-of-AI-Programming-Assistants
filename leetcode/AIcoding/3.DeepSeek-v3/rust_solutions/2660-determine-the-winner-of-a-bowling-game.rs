impl Solution {
    pub fn is_winner(player1: Vec<i32>, player2: Vec<i32>) -> i32 {
        fn calculate_score(rolls: &[i32]) -> i32 {
            let mut score = 0;
            let mut multiplier = 1;
            let mut last_strike = -10;

            for (i, &roll) in rolls.iter().enumerate() {
                if i as i32 - last_strike <= 2 && roll != 10 {
                    score += roll * multiplier;
                    if multiplier < 2 {
                        multiplier = 1;
                    }
                } else {
                    score += roll * multiplier;
                }

                if roll == 10 {
                    multiplier = 2;
                    last_strike = i as i32;
                }
            }
            score
        }

        let score1 = calculate_score(&player1);
        let score2 = calculate_score(&player2);

        if score1 > score2 {
            1
        } else if score2 > score1 {
            2
        } else {
            0
        }
    }
}