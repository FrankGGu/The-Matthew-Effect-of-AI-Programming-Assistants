#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool areDigitsEqual(char* s) {
    int count[10] = {0};
    for (int i = 0; s[i]; i++) {
        if (s[i] >= '0' && s[i] <= '9') {
            count[s[i] - '0']++;
        }
    }
    int first = -1;
    for (int i = 0; i < 10; i++) {
        if (count[i] > 0) {
            first = count[i];
            break;
        }
    }
    if (first == -1) return true;
    for (int i = 0; i < 10; i++) {
        if (count[i] > 0 && count[i] != first) {
            return false;
        }
    }
    return true;
}