#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_WORDS 1000
#define MAX_LENGTH 20

char **uncommonFromSentences(char *A, char *B, int *returnSize) {
    char **result = (char **)malloc(MAX_WORDS * sizeof(char *));
    int count[256] = {0};
    char *word;

    word = strtok(A, " ");
    while (word != NULL) {
        count[(unsigned char)word[0]]++;
        word = strtok(NULL, " ");
    }

    word = strtok(B, " ");
    while (word != NULL) {
        count[(unsigned char)word[0]]++;
        word = strtok(NULL, " ");
    }

    int index = 0;
    word = strtok(A, " ");
    while (word != NULL) {
        if (count[(unsigned char)word[0]] == 1) {
            result[index] = (char *)malloc((strlen(word) + 1) * sizeof(char));
            strcpy(result[index], word);
            index++;
        }
        word = strtok(NULL, " ");
    }

    word = strtok(B, " ");
    while (word != NULL) {
        if (count[(unsigned char)word[0]] == 1) {
            result[index] = (char *)malloc((strlen(word) + 1) * sizeof(char));
            strcpy(result[index], word);
            index++;
        }
        word = strtok(NULL, " ");
    }

    *returnSize = index;
    return result;
}