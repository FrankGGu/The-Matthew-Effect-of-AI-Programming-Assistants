#include <string.h>
#include <stdlib.h>

char * truncateSentence(char * s, int k){
    int len = strlen(s);
    int spaceCount = 0;
    int i;

    for (i = 0; i < len; i++) {
        if (s[i] == ' ') {
            spaceCount++;
            if (spaceCount == k) {
                break;
            }
        }
    }

    char *result;
    if (spaceCount < k) {
        result = (char *)malloc(sizeof(char) * (len + 1));
        strcpy(result, s);
    } else {
        result = (char *)malloc(sizeof(char) * (i + 1));
        strncpy(result, s, i);
        result[i] = '\0';
    }

    return result;
}