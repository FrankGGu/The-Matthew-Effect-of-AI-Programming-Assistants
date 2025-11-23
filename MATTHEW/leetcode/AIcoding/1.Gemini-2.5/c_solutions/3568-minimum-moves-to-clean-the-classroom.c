#include <string.h>

int minimumMovesToCleanTheClassroom(char* s, int k) {
    int n = strlen(s);
    int moves = 0;
    for (int i = 0; i < n; ++i) {
        if (s[i] == '1') {
            moves++;
            i += k - 1;
        }
    }
    return moves;
}