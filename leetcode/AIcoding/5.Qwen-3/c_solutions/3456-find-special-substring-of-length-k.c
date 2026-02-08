#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* specialSubstrings(char* s, int k) {
    int n = strlen(s);
    int count[26] = {0};
    int maxCount = 0;
    int start = 0;
    char* result = (char*)malloc(k + 1);
    for (int i = 0; i < n; i++) {
        count[s[i] - 'a']++;
        if (i >= k) {
            count[s[i - k] - 'a']--;
        }
        if (i >= k - 1) {
            int unique = 0;
            for (int j = 0; j < 26; j++) {
                if (count[j] > 0) {
                    unique++;
                }
            }
            if (unique == 1) {
                strncpy(result, s + i - k + 1, k);
                result[k] = '\0';
                return result;
            }
        }
    }
    return "";
}