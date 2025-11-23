#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char * largestMerge(char * word1, char * word2){
    int len1 = strlen(word1);
    int len2 = strlen(word2);
    int i = 0, j = 0, k = 0;
    char *result = (char *)malloc(sizeof(char) * (len1 + len2 + 1));

    while (i < len1 || j < len2) {
        if (i < len1 && j < len2) {
            if (strcmp(word1 + i, word2 + j) > 0) {
                result[k++] = word1[i++];
            } else {
                result[k++] = word2[j++];
            }
        } else if (i < len1) {
            result[k++] = word1[i++];
        } else {
            result[k++] = word2[j++];
        }
    }

    result[k] = '\0';
    return result;
}