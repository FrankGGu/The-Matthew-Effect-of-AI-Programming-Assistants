impl Solution {
    pub fn is_winner(player1: Vec<i32>, player2: Vec<i32>) -> i32 {
        let score1 = Self::calculate_score(&player1);
        let score2 = Self::calculate_score(&player2);

        if score1 > score2 {
            1
        } else if score2 > score1 {
            2
        } else {
            0
        }
    }

    fn calculate_score(player: &Vec<i32>) -> i32 {
        let mut score = 0;
        let n = player.len();

        for i in 0..n {
            score += player[i];

            if i > 0 && player[i - 1] == 10 {
                score += player[i];
            }

            if i > 1 && player[i - 2] == 10 {
                score += player[i];
            }
        }

        score
    }
}