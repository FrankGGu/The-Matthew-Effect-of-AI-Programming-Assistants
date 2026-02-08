#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minDeletions(char* s) {
    int n = strlen(s);
    int count[26] = {0};
    for (int i = 0; i < n; i++) {
        count[s[i] - 'a']++;
    }

    int deletions = 0;
    for (int i = 24; i >= 0; i--) {
        if (count[i] > count[i + 1]) {
            deletions += count[i] - count[i + 1];
            count[i] = count[i + 1];
        }
    }

    return deletions;
}