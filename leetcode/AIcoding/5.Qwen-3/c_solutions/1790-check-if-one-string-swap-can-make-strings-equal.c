#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool areAlmostEqual(char* s, char* t) {
    int diffCount = 0;
    int index1 = -1;
    int index2 = -1;

    for (int i = 0; i < strlen(s); i++) {
        if (s[i] != t[i]) {
            diffCount++;
            if (diffCount == 1) {
                index1 = i;
            } else if (diffCount == 2) {
                index2 = i;
            } else {
                return false;
            }
        }
    }

    if (diffCount == 0) {
        return true;
    } else if (diffCount == 2) {
        char temp = s[index1];
        s[index1] = s[index2];
        s[index2] = temp;
        return strcmp(s, t) == 0;
    } else {
        return false;
    }
}