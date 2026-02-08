#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool rotateString(char * s, char * goal){
    int lenS = strlen(s);
    int lenG = strlen(goal);

    if (lenS != lenG) {
        return false;
    }

    if (lenS == 0) {
        return true;
    }

    for (int i = 0; i < lenS; i++) {
        bool match = true;
        for (int j = 0; j < lenS; j++) {
            if (s[(i + j) % lenS] != goal[j]) {
                match = false;
                break;
            }
        }
        if (match) {
            return true;
        }
    }

    return false;
}