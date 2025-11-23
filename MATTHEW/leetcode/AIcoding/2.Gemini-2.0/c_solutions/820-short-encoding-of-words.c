#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int compare(const void *a, const void *b) {
    return strlen(*(char **)b) - strlen(*(char **)a);
}

int minimumLengthEncoding(char **words, int wordsSize) {
    qsort(words, wordsSize, sizeof(char *), compare);

    char *s = NULL;
    int len = 0;

    for (int i = 0; i < wordsSize; i++) {
        int found = 0;
        if (s != NULL) {
            if (strstr(s, words[i]) != NULL) {
                int pos = strstr(s, words[i]) - s;
                if (s[pos + strlen(words[i])] == '#') {
                    found = 1;
                }
            }
        }

        if (!found) {
            int word_len = strlen(words[i]);
            if (s == NULL) {
                s = (char *)malloc((word_len + 2) * sizeof(char));
                strcpy(s, words[i]);
                s[word_len] = '#';
                s[word_len + 1] = '\0';
                len += word_len + 1;
            } else {
                int current_len = strlen(s);
                s = (char *)realloc(s, (current_len + word_len + 2) * sizeof(char));
                strcpy(s + current_len, words[i]);
                s[current_len + word_len] = '#';
                s[current_len + word_len + 1] = '\0';
                len += word_len + 1;
            }
        }
    }

    free(s);
    return len;
}