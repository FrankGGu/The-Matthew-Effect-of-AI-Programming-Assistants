#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int furthestDistanceFromOrigin(char* s) {
    int count = 0;
    int max = 0;
    int len = strlen(s);
    for (int i = 0; i < len; i++) {
        if (s[i] == 'R') {
            count++;
        } else if (s[i] == 'L') {
            count--;
        }
        if (abs(count) > max) {
            max = abs(count);
        }
    }
    return max;
}