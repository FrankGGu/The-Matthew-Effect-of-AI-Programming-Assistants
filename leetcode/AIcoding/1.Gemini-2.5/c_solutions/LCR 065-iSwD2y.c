#include <stdlib.h>
#include <string.h>

static int compareStrings(const void *a, const void *b) {
    const char *s1 = *(const char **)a;
    const char *s2 = *(const char **)b;
    return strcmp(s1, s2);
}

static void reverseString(char *str) {
    int len = strlen(str);
    for (int i = 0; i < len / 2; i++) {
        char temp = str[i];
        str[i] = str[len - 1 - i];
        str[len - 1 - i] = temp;
    }
}

int minimumLengthEncoding(char **words, int wordsSize) {
    if (wordsSize == 0) {
        return 0;
    }

    char **reversed_words = (char **)malloc(wordsSize * sizeof(char *));
    if (reversed_words == NULL) {
        return 0;
    }

    for (int i = 0; i < wordsSize; i++) {
        int len = strlen(words[i]);
        reversed_words[i] = (char *)malloc((len + 1) * sizeof(char));
        if (reversed_words[i] == NULL) {
            for (int j = 0; j < i; j++) {
                free(reversed_words[j]);
            }
            free(reversed_words);
            return 0;
        }
        strcpy(reversed_words[i], words[i]);
        reverseString(reversed_words[i]);
    }

    qsort(reversed_words, wordsSize, sizeof(char *), compareStrings);

    int total_length = 0;
    for (int i = 0; i < wordsSize; i++) {
        if (i == wordsSize - 1 || strncmp(reversed_words[i], reversed_words[i+1], strlen(reversed_words[i])) != 0) {
            total_length += strlen(reversed_words[i]) + 1;
        }
    }

    for (int i = 0; i < wordsSize; i++) {
        free(reversed_words[i]);
    }
    free(reversed_words);

    return total_length;
}