#include <string.h>
#include <stdbool.h>

bool winnerOfGame(char * colors){
    int aliceMoves = 0;
    int bobMoves = 0;
    int n = strlen(colors);

    if (n < 3) {
        return false;
    }

    for (int i = 1; i < n - 1; i++) {
        if (colors[i] == 'A' && colors[i-1] == 'A' && colors[i+1] == 'A') {
            aliceMoves++;
        } else if (colors[i] == 'B' && colors[i-1] == 'B' && colors[i+1] == 'B') {
            bobMoves++;
        }
    }

    return aliceMoves > bobMoves;
}