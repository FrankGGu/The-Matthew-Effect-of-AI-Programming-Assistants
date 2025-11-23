#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countSubstrings(char *s, int k) {
    int n = strlen(s);
    int count = 0;
    for (int i = 0; i < n; i++) {
        int freq[26] = {0};
        int distinct = 0;
        for (int j = i; j < n; j++) {
            int index = s[j] - 'a';
            if (freq[index] == 0) {
                distinct++;
            }
            freq[index]++;
            if (distinct == k) {
                count++;
            } else if (distinct > k) {
                break;
            }
        }
    }
    return count;
}