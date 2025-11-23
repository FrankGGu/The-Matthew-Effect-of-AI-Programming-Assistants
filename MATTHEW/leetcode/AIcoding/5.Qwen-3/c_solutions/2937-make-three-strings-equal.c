#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int equalizeStrings(char* s1, char* s2, char* s3) {
    int len1 = strlen(s1);
    int len2 = strlen(s2);
    int len3 = strlen(s3);

    int minLen = len1;
    if (len2 < minLen) minLen = len2;
    if (len3 < minLen) minLen = len3;

    int count = 0;
    for (int i = 0; i < minLen; i++) {
        if (s1[i] == s2[i] && s2[i] == s3[i]) {
            count++;
        }
    }

    return count;
}