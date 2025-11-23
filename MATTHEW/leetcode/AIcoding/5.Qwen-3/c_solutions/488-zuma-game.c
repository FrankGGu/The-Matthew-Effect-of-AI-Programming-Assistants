#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char *s;
    int count;
} State;

int canWin(char *s, int n) {
    if (n == 0) return 1;
    for (int i = 0; i < n; i++) {
        int j = i;
        while (j < n && s[j] == s[i]) j++;
        if (j - i >= 2) {
            char *new_s = malloc(n - (j - i) + 1);
            strncpy(new_s, s, i);
            strncpy(new_s + i, s + j, n - j);
            new_s[n - j + i] = '\0';
            if (canWin(new_s, n - (j - i))) {
                free(new_s);
                return 1;
            }
            free(new_s);
        }
    }
    return 0;
}

int findMinStep(char *target, char *board) {
    int len = strlen(board);
    char *new_board = malloc(len + 1);
    strcpy(new_board, board);
    int result = 0;
    for (int i = 0; i <= len; i++) {
        for (int j = 0; j < strlen(target); j++) {
            char *new_board2 = malloc(len + 2);
            strncpy(new_board2, new_board, i);
            new_board2[i] = target[j];
            strncpy(new_board2 + i + 1, new_board + i, len - i);
            new_board2[len + 1] = '\0';
            if (canWin(new_board2, len + 1)) {
                free(new_board);
                free(new_board2);
                return 1;
            }
            free(new_board2);
        }
    }
    free(new_board);
    return 0;
}