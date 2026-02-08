#include <stdio.h>
#include <stdlib.h>
#include <string.h>

long long countBalancedPermutations(char* s) {
    int n = strlen(s);
    int freq[26] = {0};
    for (int i = 0; i < n; i++) {
        freq[s[i] - 'A']++;
    }

    long long total = 1;
    for (int i = 0; i < n; i++) {
        total *= (i + 1);
    }

    for (int i = 0; i < 26; i++) {
        for (int j = 1; j <= freq[i]; j++) {
            total /= j;
        }
    }

    return total;
}