#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minDeletionsToKSpecial(char* s, int k) {
    int freq[26] = {0};
    int n = strlen(s);
    for (int i = 0; i < n; i++) {
        freq[s[i] - 'a']++;
    }

    int deletions = 0;
    for (int i = 0; i < 26; i++) {
        if (freq[i] == 0) continue;
        int count = 0;
        for (int j = i + 1; j < 26; j++) {
            if (freq[j] == 0) continue;
            if (freq[j] == freq[i]) {
                count++;
            }
        }
        if (count >= k) {
            deletions += (count - k + 1);
        } else {
            deletions += (count + 1);
        }
    }

    return deletions;
}