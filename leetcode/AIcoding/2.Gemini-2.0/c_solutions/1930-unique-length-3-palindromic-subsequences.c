#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countPalindromicSubsequence(char * s){
    int count = 0;
    for (char c = 'a'; c <= 'z'; c++) {
        int first = -1, last = -1;
        for (int i = 0; s[i] != '\0'; i++) {
            if (s[i] == c) {
                if (first == -1) {
                    first = i;
                }
                last = i;
            }
        }
        if (first == -1) continue;

        bool seen[26] = {false};
        int distinct = 0;
        for (int i = first + 1; i < last; i++) {
            if (!seen[s[i] - 'a']) {
                seen[s[i] - 'a'] = true;
                distinct++;
            }
        }
        count += distinct;
    }
    return count;
}