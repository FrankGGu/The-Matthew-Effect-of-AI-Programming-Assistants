#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int isSubsequence(const char *s, const char *t) {
    int i = 0, j = 0;
    while (s[i] && t[j]) {
        if (s[i] == t[j]) {
            i++;
        }
        j++;
    }
    return s[i] == '\0';
}

char * findLongestWord(char * s, char ** dictionary, int dictionarySize){
    char *longestWord = "";
    int longestLength = 0;

    for (int i = 0; i < dictionarySize; i++) {
        if (isSubsequence(dictionary[i], s)) {
            int currentLength = strlen(dictionary[i]);
            if (currentLength > longestLength) {
                longestWord = dictionary[i];
                longestLength = currentLength;
            } else if (currentLength == longestLength && strcmp(dictionary[i], longestWord) < 0) {
                longestWord = dictionary[i];
            }
        }
    }

    if (longestLength == 0) return "";

    char *result = (char*)malloc(strlen(longestWord) + 1);
    strcpy(result, longestWord);
    return result;
}