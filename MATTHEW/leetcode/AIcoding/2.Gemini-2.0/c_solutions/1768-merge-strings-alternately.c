#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char * mergeAlternately(char * word1, char * word2){
    int len1 = 0, len2 = 0;
    while (word1[len1] != '\0') len1++;
    while (word2[len2] != '\0') len2++;

    int len = len1 + len2;
    char *result = (char *)malloc(sizeof(char) * (len + 1));
    int i = 0, j = 0, k = 0;

    while (i < len1 || j < len2) {
        if (i < len1) {
            result[k++] = word1[i++];
        }
        if (j < len2) {
            result[k++] = word2[j++];
        }
    }
    result[k] = '\0';
    return result;
}