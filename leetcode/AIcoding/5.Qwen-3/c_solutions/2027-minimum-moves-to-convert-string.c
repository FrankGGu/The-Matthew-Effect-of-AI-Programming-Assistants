#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minimumMoves(char* s) {
    int n = strlen(s);
    int moves = 0;
    for (int i = 0; i < n; i += 3) {
        moves++;
    }
    return moves;
}