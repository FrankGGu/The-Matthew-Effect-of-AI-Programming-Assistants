#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool canWin(char* s) {
    int n = strlen(s);
    for (int i = 0; i < n - 1; i++) {
        if (s[i] == 'A' && s[i + 1] == 'B') {
            char* new_s = (char*)malloc(n * sizeof(char));
            strncpy(new_s, s, i);
            strncpy(new_s + i, s + i + 2, n - i - 2);
            new_s[n - 2] = '\0';
            if (!canWin(new_s)) {
                free(new_s);
                return true;
            }
            free(new_s);
        }
    }
    return false;
}