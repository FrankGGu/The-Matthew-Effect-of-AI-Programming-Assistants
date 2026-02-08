#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char ** uncommonFromSentences(char * s1, char * s2, int* returnSize){
    int s1_len = strlen(s1);
    int s2_len = strlen(s2);
    char *combined = (char *)malloc((s1_len + s2_len + 2) * sizeof(char));
    strcpy(combined, s1);
    strcat(combined, " ");
    strcat(combined, s2);

    int count = 0;
    for (int i = 0; combined[i] != '\0'; i++) {
        if (combined[i] == ' ') {
            count++;
        }
    }
    count++;

    char **words = (char **)malloc(count * sizeof(char *));
    char *token = strtok(combined, " ");
    int word_count = 0;
    while (token != NULL) {
        words[word_count] = (char *)malloc((strlen(token) + 1) * sizeof(char));
        strcpy(words[word_count], token);
        word_count++;
        token = strtok(NULL, " ");
    }

    int *freq = (int *)calloc(word_count, sizeof(int));
    for (int i = 0; i < word_count; i++) {
        for (int j = 0; j < word_count; j++) {
            if (strcmp(words[i], words[j]) == 0) {
                freq[i]++;
            }
        }
    }

    int uncommon_count = 0;
    for (int i = 0; i < word_count; i++) {
        if (freq[i] == 1) {
            uncommon_count++;
        }
    }

    char **result = (char **)malloc(uncommon_count * sizeof(char *));
    int result_index = 0;
    for (int i = 0; i < word_count; i++) {
        if (freq[i] == 1) {
            result[result_index] = (char *)malloc((strlen(words[i]) + 1) * sizeof(char));
            strcpy(result[result_index], words[i]);
            result_index++;
        }
    }

    *returnSize = uncommon_count;

    for (int i = 0; i < word_count; i++) {
        free(words[i]);
    }
    free(words);
    free(freq);
    free(combined);

    return result;
}