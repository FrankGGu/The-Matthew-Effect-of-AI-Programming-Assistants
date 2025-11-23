#include <stdlib.h>
#include <string.h>

int compareStringsByLengthDesc(const void *a, const void *b) {
    const char *s1 = *(const char **)a;
    const char *s2 = *(const char **)b;
    return strlen(s2) - strlen(s1);
}

int minimumLengthEncoding(char **words, int wordsSize) {
    qsort(words, wordsSize, sizeof(char *), compareStringsByLengthDesc);

    int total_length = 0;
    char *is_covered = (char *)calloc(wordsSize, sizeof(char));

    for (int i = 0; i < wordsSize; ++i) {
        if (is_covered[i]) {
            continue;
        }

        total_length += strlen(words[i]) + 1;

        for (int j = i + 1; j < wordsSize; ++j) {
            if (is_covered[j]) {
                continue;
            }

            int len_i = strlen(words[i]);
            int len_j = strlen(words[j]);

            if (len_j <= len_i) {
                if (strcmp(words[i] + (len_i - len_j), words[j]) == 0) {
                    is_covered[j] = 1;
                }
            }
        }
    }

    free(is_covered);

    return total_length;
}