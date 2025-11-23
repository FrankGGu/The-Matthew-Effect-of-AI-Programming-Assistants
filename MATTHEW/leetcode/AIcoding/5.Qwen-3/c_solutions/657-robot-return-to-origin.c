#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool judgeCircle(char* s) {
    int x = 0, y = 0;
    for (int i = 0; s[i] != '\0'; i++) {
        switch (s[i]) {
            case 'U': y++; break;
            case 'D': y--; break;
            case 'L': x--; break;
            case 'R': x++; break;
        }
    }
    return (x == 0 && y == 0);
}