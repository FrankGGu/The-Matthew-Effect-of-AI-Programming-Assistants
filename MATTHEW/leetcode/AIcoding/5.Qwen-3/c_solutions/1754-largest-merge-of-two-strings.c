#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* largestMerge(char* s1, char* s2) {
    int len1 = strlen(s1);
    int len2 = strlen(s2);
    char* result = (char*)malloc((len1 + len2 + 1) * sizeof(char));
    int i = 0, j = 0, k = 0;

    while (i < len1 && j < len2) {
        if (s1[i] > s2[j]) {
            result[k++] = s1[i++];
        } else if (s1[i] < s2[j]) {
            result[k++] = s2[j++];
        } else {
            int a = i, b = j;
            while (a < len1 && b < len2 && s1[a] == s2[b]) {
                a++;
                b++;
            }
            if (a == len1 || (b < len2 && s1[a] < s2[b])) {
                result[k++] = s2[j++];
            } else {
                result[k++] = s1[i++];
            }
        }
    }

    while (i < len1) {
        result[k++] = s1[i++];
    }

    while (j < len2) {
        result[k++] = s2[j++];
    }

    result[k] = '\0';
    return result;
}