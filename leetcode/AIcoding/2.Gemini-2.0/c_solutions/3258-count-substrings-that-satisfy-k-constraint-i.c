#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countSubstrings(char * s, int k){
    int n = strlen(s);
    int count = 0;
    for (int i = 0; i < n; i++) {
        int distinct = 0;
        int freq[26] = {0};
        for (int j = i; j < n; j++) {
            if (freq[s[j] - 'a'] == 0) {
                distinct++;
            }
            freq[s[j] - 'a']++;
            if (distinct == k) {
                count++;
            }
        }
    }
    return count;
}