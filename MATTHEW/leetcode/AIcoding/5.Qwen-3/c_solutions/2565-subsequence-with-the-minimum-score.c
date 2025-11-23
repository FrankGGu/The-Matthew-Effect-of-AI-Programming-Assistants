#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* minSubsequence(int n, char* s) {
    int count[26] = {0};
    for (int i = 0; i < n; i++) {
        count[s[i] - 'a']++;
    }

    int i = 0;
    int j = 0;
    char* result = (char*)malloc((n + 1) * sizeof(char));
    while (i < n) {
        if (count[s[i] - 'a'] == 1) {
            result[j++] = s[i];
            i++;
        } else {
            int k = i + 1;
            while (k < n && count[s[k] - 'a'] > 1) {
                k++;
            }
            if (k < n) {
                result[j++] = s[i];
                i++;
            } else {
                break;
            }
        }
    }
    result[j] = '\0';
    return result;
}