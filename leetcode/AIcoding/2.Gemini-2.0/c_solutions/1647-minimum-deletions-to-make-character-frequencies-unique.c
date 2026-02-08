#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minDeletions(char * s){
    int freq[26] = {0};
    for (int i = 0; s[i] != '\0'; i++) {
        freq[s[i] - 'a']++;
    }

    int deletions = 0;
    int used[100001] = {0};
    for (int i = 0; i < 26; i++) {
        while (freq[i] > 0 && used[freq[i]]) {
            freq[i]--;
            deletions++;
        }
        if (freq[i] > 0) {
            used[freq[i]] = 1;
        }
    }

    return deletions;
}