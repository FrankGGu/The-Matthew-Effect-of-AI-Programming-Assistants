impl Solution {
    pub fn is_winner(player1: Vec<i32>, player2: Vec<i32>) -> String {
        let (mut score1, mut score2) = (0, 0);
        let (n1, n2) = (player1.len(), player2.len());

        for i in 0..n1 {
            score1 += player1[i];
            if i > 0 && player1[i - 1] == 10 {
                score1 += player1[i];
            }
        }

        for i in 0..n2 {
            score2 += player2[i];
            if i > 0 && player2[i - 1] == 10 {
                score2 += player2[i];
            }
        }

        if score1 > score2 {
            "Player 1".to_string()
        } else if score2 > score1 {
            "Player 2".to_string()
        } else {
            "Tie".to_string()
        }
    }
}