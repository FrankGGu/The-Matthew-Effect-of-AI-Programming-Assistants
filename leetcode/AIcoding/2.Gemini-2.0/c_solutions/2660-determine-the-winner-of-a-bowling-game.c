#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int isStrike(int* player, int i) {
    if (i >= 0 && i < 10000 && player[i] == 10) {
        return 1;
    }
    return 0;
}

int calculateScore(int* player, int playerSize) {
    int score = 0;
    for (int i = 0; i < playerSize; i++) {
        if (isStrike(player, i)) {
            score += player[i];
            if (i + 1 < playerSize) {
                score += player[i + 1];
            }
            if (i + 2 < playerSize) {
                score += player[i + 2];
            }
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