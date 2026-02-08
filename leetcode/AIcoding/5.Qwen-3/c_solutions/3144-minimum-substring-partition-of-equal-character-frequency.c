#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* partitionString(char* s) {
    int len = strlen(s);
    int* freq = (int*)calloc(26, sizeof(int));
    int unique = 0;
    int start = 0;
    int* last = (int*)calloc(26, sizeof(int));
    for (int i = 0; i < 26; i++) {
        last[i] = -1;
    }

    char* result = (char*)malloc((len + 1) * sizeof(char));
    int resIndex = 0;

    for (int i = 0; i < len; i++) {
        int c = s[i] - 'a';
        if (last[c] >= start) {
            for (int j = start; j <= last[c]; j++) {
                int ch = s[j] - 'a';
                freq[ch]--;
                if (freq[ch] == 0) {
                    unique--;
                }
            }
            start = last[c] + 1;
        }
        last[c] = i;
        if (freq[c] == 0) {
            unique++;
        }
        freq[c]++;
        if (unique == 26) {
            result[resIndex++] = '|';
            resIndex--;
            start = i + 1;
            memset(freq, 0, 26 * sizeof(int));
            unique = 0;
        }
        result[resIndex++] = s[i];
    }

    result[resIndex] = '\0';
    return result;
}