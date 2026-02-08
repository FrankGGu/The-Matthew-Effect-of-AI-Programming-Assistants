#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minNumberOfFrogsCroaking(char* croak) {
    int count[26] = {0};
    int prev[26] = {0};
    char order[] = "croak";
    for (int i = 0; i < 5; i++) {
        prev[order[i] - 'a'] = order[(i + 4) % 5] - 'a';
    }
    int frogs = 0;
    int max_frogs = 0;
    for (int i = 0; i < strlen(croak); i++) {
        char c = croak[i];
        int idx = c - 'a';
        if (count[idx] == 0) {
            if (idx != 0) return -1;
        } else {
            count[idx]--;
            if (idx != 0) {
                count[prev[idx]]++;
            }
        }
        if (idx == 0) {
            frogs++;
            max_frogs = (frogs > max_frogs) ? frogs : max_frogs;
        }
    }
    for (int i = 1; i < 5; i++) {
        if (count[order[i] - 'a'] > 0) return -1;
    }
    return max_frogs;
}