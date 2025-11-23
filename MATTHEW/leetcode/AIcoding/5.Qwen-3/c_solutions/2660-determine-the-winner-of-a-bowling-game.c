#include <stdio.h>
#include <stdlib.h>

int isWinner(int* player1, int player1Size, int* player2, int player2Size) {
    int score1 = 0, score2 = 0;
    for (int i = 0; i < player1Size; i++) {
        score1 += player1[i];
        if (i < player1Size - 1 && player1[i] == 10) {
            score1 += player1[i + 1];
            if (i + 1 < player1Size - 1) {
                score1 += player1[i + 2];
            }
        } else if (i < player1Size - 2 && player1[i] + player1[i + 1] == 10) {
            score1 += player1[i + 2];
        }
    }
    for (int i = 0; i < player2Size; i++) {
        score2 += player2[i];
        if (i < player2Size - 1 && player2[i] == 10) {
            score2 += player2[i + 1];
            if (i + 1 < player2Size - 1) {
                score2 += player2[i + 2];
            }
        } else if (i < player2Size - 2 && player2[i] + player2[i + 1] == 10) {
            score2 += player2[i + 2];
        }
    }
    if (score1 > score2) return 1;
    if (score2 > score1) return 2;
    return 0;
}