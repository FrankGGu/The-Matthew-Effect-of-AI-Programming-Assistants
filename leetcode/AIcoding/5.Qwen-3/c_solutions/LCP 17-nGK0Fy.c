#include <stdio.h>
#include <stdlib.h>

int calculate(char* s) {
    int x = 0, y = 0;
    for (int i = 0; s[i] != '\0'; i++) {
        if (s[i] == 'A') {
            x = x + y + 1;
        } else if (s[i] == 'B') {
            y = x + y + 1;
        }
    }
    return x + y;
}