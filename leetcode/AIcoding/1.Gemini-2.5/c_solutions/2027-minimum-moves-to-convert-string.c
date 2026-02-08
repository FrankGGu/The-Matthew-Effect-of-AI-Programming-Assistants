#include <string.h>

int minimumMoves(char * s){
    int n = strlen(s);
    int moves = 0;
    int i = 0;
    while (i < n) {
        if (s[i] == 'X') {
            moves++;
            i += 3;
        } else {
            i++;
        }
    }
    return moves;
}