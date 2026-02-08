#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int sumDigitDifferences(char* s, char* t) {
    int n = strlen(s);
    int result = 0;
    int* count = (int*)calloc(26, sizeof(int));

    for (int i = 0; i < n; i++) {
        count[s[i] - 'a']++;
    }

    for (int i = 0; i < n; i++) {
        if (count[t[i] - 'a'] > 0) {
            count[t[i] - 'a']--;
        } else {
            result++;
        }
    }

    free(count);
    return result;
}