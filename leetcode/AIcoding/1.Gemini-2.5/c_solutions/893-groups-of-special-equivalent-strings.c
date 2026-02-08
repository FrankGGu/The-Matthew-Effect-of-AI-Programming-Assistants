#include <stdlib.h>
#include <string.h>

int compareStrings(const void* a, const void* b) {
    return strcmp(*(const char**)a, *(const char**)b);
}

int numSpecialEquivGroups(char** words, int wordsSize) {
    if (wordsSize == 0) {
        return 0;
    }

    char** signatures = (char**)malloc(wordsSize * sizeof(char*));

    for (int i = 0; i < wordsSize; i++) {
        int even_freq[26] = {0};
        int odd_freq[26] = {0};
        char* s = words[i];
        int len = strlen(s);

        for (int j = 0; j < len; j++) {
            if (j % 2 == 0) {
                even_freq[s[j] - 'a']++;
            } else {
                odd_freq[s[j] - 'a']++;
            }
        }

        signatures[i] = (char*)malloc(53 * sizeof(char));

        for (int j = 0; j < 26; j++) {
            signatures[i][j] = (char)even_freq[j];
            signatures[i][j+26] = (char)odd_freq[j];
        }
        signatures[i][52] = '\0';
    }

    qsort(signatures, wordsSize, sizeof(char*), compareStrings);

    int groups = 0;
    if (wordsSize > 0) {
        groups = 1;
        for (int i = 1; i < wordsSize; i++) {
            if (strcmp(signatures[i], signatures[i-1]) != 0) {
                groups++;
            }
        }
    }

    for (int i = 0; i < wordsSize; i++) {
        free(signatures[i]);
    }
    free(signatures);

    return groups;
}