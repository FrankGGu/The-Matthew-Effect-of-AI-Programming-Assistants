class Solution {
    public String determineWinner(int[] player1, int[] player2) {
        int score1 = 0, score2 = 0;

        for (int i = 0; i < player1.length; i++) {
            score1 += player1[i];
            score2 += player2[i];
        }

        if (score1 > score2) {
            return "Player 1";
        } else if (score2 > score1) {
            return "Player 2";
        } else {
            return "Tie";
        }
    }
}