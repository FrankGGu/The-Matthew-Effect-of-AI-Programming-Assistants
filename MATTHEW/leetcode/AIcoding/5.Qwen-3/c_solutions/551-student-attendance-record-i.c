#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool checkRecord(char* s) {
    int countA = 0;
    for (int i = 0; i < strlen(s); i++) {
        if (s[i] == 'A') {
            countA++;
            if (countA >= 2) {
                return false;
            }
        } else if (s[i] == 'L' && i + 1 < strlen(s) && s[i + 1] == 'L' && i + 2 < strlen(s) && s[i + 2] == 'L') {
            return false;
        }
    }
    return true;
}