#include <stdlib.h>
#include <string.h>

char *customSortString(char *S, char *T) {
    int counts[26] = {0};
    int i;

    for (i = 0; T[i] != '\0'; i++) {
        counts[T[i] - 'a']++;
    }

    char *result = (char *)malloc(strlen(T) + 1);
    if (result == NULL) {
        return NULL;
    }
    int k = 0;

    for (i = 0; S[i] != '\0'; i++) {
        char c = S[i];
        while (counts[c - 'a'] > 0) {
            result[k++] = c;
            counts[c - 'a']--;
        }
    }

    for (i = 0; i < 26; i++) {
        char c = 'a' + i;
        while (counts[i] > 0) {
            result[k++] = c;
            counts[i]--;
        }
    }

    result[k] = '\0';

    return result;
}