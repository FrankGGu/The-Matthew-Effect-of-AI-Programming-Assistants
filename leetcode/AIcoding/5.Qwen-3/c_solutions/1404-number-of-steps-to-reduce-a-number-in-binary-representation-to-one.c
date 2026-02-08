#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int numSteps(char* s) {
    int steps = 0;
    int len = strlen(s);
    for (int i = len - 1; i > 0; i--) {
        if (s[i] == '1') {
            steps += 2;
        } else {
            steps++;
        }
    }
    if (s[0] == '1' && len > 1) {
        steps++;
    }
    return steps;
}