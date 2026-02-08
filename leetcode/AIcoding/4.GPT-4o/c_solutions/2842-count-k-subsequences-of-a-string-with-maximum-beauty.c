#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MOD 1000000007

int countKSubsequencesWithMaxBeauty(char *s, int k) {
    int freq[26] = {0};
    int len = strlen(s);

    for (int i = 0; i < len; i++) {
        freq[s[i] - 'a']++;
    }

    int maxBeauty = 0;
    for (int i = 0; i < 26; i++) {
        if (freq[i] > 0) {
            maxBeauty++;
        }
    }

    if (k > maxBeauty) return 0;

    int count = 0;
    for (int i = 0; i < 26; i++) {
        if (freq[i] > 0) {
            count++;
        }
    }

    int result = 1;
    for (int i = 0; i < k; i++) {
        result = (result * (count - i)) % MOD;
    }

    return result;
}