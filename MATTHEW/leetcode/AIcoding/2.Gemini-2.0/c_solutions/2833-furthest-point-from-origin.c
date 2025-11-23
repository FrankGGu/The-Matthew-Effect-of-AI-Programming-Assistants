#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int furthestDistanceFromOrigin(char * moves) {
    int l = 0, r = 0, q = 0;
    for (int i = 0; moves[i] != '\0'; i++) {
        if (moves[i] == 'L') {
            l++;
        } else if (moves[i] == 'R') {
            r++;
        } else {
            q++;
        }
    }
    return abs(r - l) + q;
}