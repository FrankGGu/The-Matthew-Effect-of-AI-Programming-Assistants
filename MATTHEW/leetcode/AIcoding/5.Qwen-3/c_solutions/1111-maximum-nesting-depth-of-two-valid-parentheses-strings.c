#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* maxDepthAfterInsertion(char* s) {
    int n = strlen(s);
    char* result = (char*)malloc((n + 1) * sizeof(char));
    int depth = 0;
    int i = 0;
    while (i < n) {
        if (s[i] == '(') {
            result[i] = 'a' + (depth % 2);
            depth++;
        } else {
            depth--;
            result[i] = 'a' + (depth % 2);
        }
        i++;
    }
    result[n] = '\0';
    return result;
}