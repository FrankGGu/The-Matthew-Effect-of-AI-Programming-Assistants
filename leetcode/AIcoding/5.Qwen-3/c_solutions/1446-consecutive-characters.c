#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxPower(char* s) {
    int max = 1;
    int current = 1;
    for (int i = 1; s[i]; i++) {
        if (s[i] == s[i - 1]) {
            current++;
            if (current > max) {
                max = current;
            }
        } else {
            current = 1;
        }
    }
    return max;
}