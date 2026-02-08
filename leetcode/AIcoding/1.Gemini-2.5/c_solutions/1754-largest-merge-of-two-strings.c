#include <stdlib.h>
#include <string.h>

char* largestMerge(char* word1, char* word2) {
    int len1 = strlen(word1);
    int len2 = strlen(word2);
    int totalLen = len1 + len2;

    char* merge = (char*)malloc(sizeof(char) * (totalLen + 1));
    if (merge == NULL) {
        return NULL;
    }

    int i = 0;
    int j = 0;
    int k = 0;

    while (i < len1 || j < len2) {
        if (i < len1 && j < len2) {
            if (strcmp(word1 + i, word2 + j) > 0) {
                merge[k++] = word1[i++];
            } else {
                merge[k++] = word2[j++];
            }
        } else if (i < len1) {
            merge[k++] = word1[i++];
        } else { // j < len2
            merge[k++] = word2[j++];
        }
    }

    merge[k] = '\0';

    return merge;
}