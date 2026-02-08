#include <stdlib.h>
#include <string.h>

int calculate_hamming_distance(char *s1, char *s2) {
    int dist = 0;
    int len = strlen(s1);
    for (int i = 0; i < len; i++) {
        if (s1[i] != s2[i]) {
            dist++;
        }
    }
    return dist;
}

char **twoEditWords(char **queries, int queriesSize, char **dictionary, int dictionarySize, int *returnSize) {
    char **result = (char **)malloc(queriesSize * sizeof(char *));
    *returnSize = 0;

    if (queriesSize == 0) {
        return result;
    }

    int word_len = strlen(queries[0]);

    for (int i = 0; i < queriesSize; i++) {
        char *current_query = queries[i];
        int found_match = 0;
        for (int j = 0; j < dictionarySize; j++) {
            char *current_dict_word = dictionary[j];
            if (calculate_hamming_distance(current_query, current_dict_word) <= 2) {
                result[*returnSize] = (char *)malloc((word_len + 1) * sizeof(char));
                strcpy(result[*returnSize], current_query);
                (*returnSize)++;
                found_match = 1;
                break;
            }
        }
    }

    return result;
}