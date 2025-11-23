#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* longestSubsequenceRepeatedK(char* s, int k) {
    int len = strlen(s);
    int freq[26] = {0};
    for (int i = 0; i < len; i++) {
        freq[s[i] - 'a']++;
    }
    int max_len = 0;
    for (int i = 0; i < 26; i++) {
        if (freq[i] >= k) {
            max_len++;
        }
    }
    char* result = (char*)malloc((max_len + 1) * sizeof(char));
    int idx = 0;
    for (int i = 0; i < 26; i++) {
        if (freq[i] >= k) {
            result[idx++] = 'a' + i;
        }
    }
    result[idx] = '\0';
    return result;
}