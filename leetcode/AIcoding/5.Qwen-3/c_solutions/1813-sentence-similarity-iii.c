#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int isSimilar(char* sentence1, char* sentence2) {
    char* token1 = strtok(sentence1, " ");
    char* token2 = strtok(sentence2, " ");

    while (token1 != NULL && token2 != NULL) {
        if (strcmp(token1, token2) != 0) {
            return 0;
        }
        token1 = strtok(NULL, " ");
        token2 = strtok(NULL, " ");
    }

    return (token1 == NULL && token2 == NULL);
}

int areSentencesSimilar(char* sentence1, char* sentence2) {
    char* s1 = strdup(sentence1);
    char* s2 = strdup(sentence2);

    int result = isSimilar(s1, s2);

    free(s1);
    free(s2);

    return result;
}