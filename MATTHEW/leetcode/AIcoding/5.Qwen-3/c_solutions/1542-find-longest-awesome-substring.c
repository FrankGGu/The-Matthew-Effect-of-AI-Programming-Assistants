#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int longestAwesome(char* s) {
    int n = strlen(s);
    int maxLen = 0;
    int mask = 0;
    int hash[1024];
    memset(hash, -1, sizeof(hash));
    hash[0] = -1;
    for (int i = 0; i < n; ++i) {
        int digit = s[i] - '0';
        mask ^= (1 << digit);
        if (hash[mask] == -1) {
            hash[mask] = i;
        } else {
            maxLen = fmax(maxLen, i - hash[mask]);
        }
        for (int d = 0; d < 10; ++d) {
            int temp = mask ^ (1 << d);
            if (hash[temp] != -1) {
                maxLen = fmax(maxLen, i - hash[temp]);
            }
        }
    }
    return maxLen;
}