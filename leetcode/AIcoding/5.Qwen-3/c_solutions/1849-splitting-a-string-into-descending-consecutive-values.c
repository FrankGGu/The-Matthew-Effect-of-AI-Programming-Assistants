#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool helper(char *s, int start, long prev, int count) {
    if (start == strlen(s)) {
        return count >= 2;
    }
    for (int i = start; i < strlen(s); i++) {
        long curr = strtol(s + start, NULL, 10);
        if (curr > prev) break;
        if (count >= 2 && curr != prev - 1) continue;
        if (helper(s, i + 1, curr, count + 1)) return true;
    }
    return false;
}

bool splitString(char *s) {
    for (int i = 0; i < strlen(s) - 1; i++) {
        long first = strtol(s, NULL, 10);
        if (helper(s, i + 1, first, 1)) return true;
    }
    return false;
}