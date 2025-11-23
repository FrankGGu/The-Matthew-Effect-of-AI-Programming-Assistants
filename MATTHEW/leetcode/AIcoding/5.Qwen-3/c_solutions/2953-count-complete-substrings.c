#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countCompleteSubstrings(char* s) {
    int result = 0;
    int n = strlen(s);
    for (int i = 0; i < n; i++) {
        int freq[26] = {0};
        int maxFreq = 0;
        for (int j = i; j < n; j++) {
            freq[s[j] - 'a']++;
            if (freq[s[j] - 'a'] > maxFreq) {
                maxFreq = freq[s[j] - 'a'];
            }
            int unique = 0;
            for (int k = 0; k < 26; k++) {
                if (freq[k] > 0) {
                    unique++;
                }
            }
            if (maxFreq == 1 || (unique == 2 && maxFreq == 2)) {
                result++;
            }
        }
    }
    return result;
}