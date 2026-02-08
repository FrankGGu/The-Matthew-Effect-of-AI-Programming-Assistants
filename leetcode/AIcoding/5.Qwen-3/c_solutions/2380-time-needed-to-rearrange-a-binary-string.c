#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int reorganizeString(char* s, int k) {
    if (k == 0) return 0;
    int freq[26] = {0};
    int maxFreq = 0;
    int countMax = 0;
    for (int i = 0; s[i]; i++) {
        int idx = s[i] - 'a';
        freq[idx]++;
        if (freq[idx] > maxFreq) {
            maxFreq = freq[idx];
            countMax = 1;
        } else if (freq[idx] == maxFreq) {
            countMax++;
        }
    }

    int total = (maxFreq - 1) * k + countMax;
    return (strlen(s) > total) ? (strlen(s) - total) : 0;
}