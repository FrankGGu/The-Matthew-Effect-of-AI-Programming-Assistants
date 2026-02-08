#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minSteps(char *s, char *t) {
    int count[26] = {0};
    int i;
    for (i = 0; s[i]; i++) {
        count[s[i] - 'a']++;
    }
    for (i = 0; t[i]; i++) {
        count[t[i] - 'a']--;
    }
    int steps = 0;
    for (i = 0; i < 26; i++) {
        steps += abs(count[i]);
    }
    return steps;
}