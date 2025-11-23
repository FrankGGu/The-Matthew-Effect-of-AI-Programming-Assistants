int calculateScore(int* player, int n) {
    int score = 0;
    for (int i = 0; i < n; i++) {
        if ((i > 0 && player[i - 1] == 10) || (i > 1 && player[i - 2] == 10)) {
            score += 2 * player[i];
        } else {
            score += player[i];
        }
    }
    return score;
}

int isWinner(int* player1, int player1Size, int* player2, int player2Size) {
    int score1 = calculateScore(player1, player1Size);
    int score2 = calculateScore(player2, player2Size);

    if (score1 > score2) {
        return 1;
    } else if (score2 > score1) {
        return 2;
    } else {
        return 0;
    }
}