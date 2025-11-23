#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minDeletions(char* s, int k) {
    int freq[26] = {0};
    int len = strlen(s);
    for (int i = 0; i < len; i++) {
        freq[s[i] - 'a']++;
    }

    int deletions = 0;
    for (int i = 0; i < 26; i++) {
        while (freq[i] > k) {
            deletions++;
            freq[i]--;
        }
    }

    return deletions;
}