class Solution {
    public int isWinner(int[] player1, int[] player2) {
        int score1 = calculateScore(player1);
        int score2 = calculateScore(player2);

        if (score1 > score2) {
            return 1;
        } else if (score2 > score1) {
            return 2;
        } else {
            return 0;
        }
    }

    private int calculateScore(int[] rolls) {
        int score = 0;
        for (int i = 0; i < rolls.length; i++) {
            if ((i >= 1 && rolls[i - 1] == 10) || (i >= 2 && rolls[i - 2] == 10)) {
                score += 2 * rolls[i];
            } else {
                score += rolls[i];
            }
        }
        return score;
    }
}