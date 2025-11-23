#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char * reorganizeString(char * s){
    int len = 0;
    while (s[len] != '\0') {
        len++;
    }

    int counts[26] = {0};
    for (int i = 0; i < len; i++) {
        counts[s[i] - 'a']++;
    }

    int maxCount = 0;
    int maxChar = 0;
    for (int i = 0; i < 26; i++) {
        if (counts[i] > maxCount) {
            maxCount = counts[i];
            maxChar = i;
        }
    }

    if (maxCount > (len + 1) / 2) {
        return "";
    }

    char *result = (char *)malloc(sizeof(char) * (len + 1));
    result[len] = '\0';
    int index = 0;

    while (counts[maxChar] > 0) {
        result[index] = maxChar + 'a';
        index += 2;
        counts[maxChar]--;
    }

    for (int i = 0; i < 26; i++) {
        while (counts[i] > 0) {
            if (index >= len) {
                index = 1;
            }
            result[index] = i + 'a';
            index += 2;
            counts[i]--;
        }
    }

    return result;
}