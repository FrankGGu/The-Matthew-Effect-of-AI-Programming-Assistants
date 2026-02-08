#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char * rearrangeWords(char * text) {
    int n = strlen(text);
    char **words = malloc(n * sizeof(char *));
    int count = 0, start = 0;

    for (int i = 0; i <= n; i++) {
        if (text[i] == ' ' || text[i] == '\0') {
            words[count] = malloc((i - start + 1) * sizeof(char));
            memcpy(words[count], text + start, i - start);
            words[count][i - start] = '\0';
            count++;
            start = i + 1;
        }
    }

    qsort(words, count, sizeof(char *), (int (*)(const void *, const void *)) strcmp);

    char *result = malloc(n + 1);
    strcpy(result, words[0]);
    for (int i = 1; i < count; i++) {
        strcat(result, " ");
        strcat(result, words[i]);
    }

    for (int i = 0; i < count; i++) {
        free(words[i]);
    }
    free(words);

    result[0] = tolower(result[0]);
    return result;
}