#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int longestContinuousSubstring(char * s){
    int n = strlen(s);
    int maxLength = 1;
    int currentLength = 1;
    for (int i = 1; i < n; i++) {
        if (s[i] == s[i - 1] + 1) {
            currentLength++;
        } else {
            maxLength = (maxLength > currentLength) ? maxLength : currentLength;
            currentLength = 1;
        }
    }
    maxLength = (maxLength > currentLength) ? maxLength : currentLength;
    return maxLength;
}