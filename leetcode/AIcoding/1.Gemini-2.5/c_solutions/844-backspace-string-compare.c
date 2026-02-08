#include <stdbool.h>
#include <string.h>
#include <stdlib.h>

char* processString(char* str) {
    int len = strlen(str);
    char* processed = (char*)malloc(sizeof(char) * (len + 1));
    if (!processed) {
        return NULL; 
    }

    int k = 0;

    for (int i = 0; i < len; i++) {
        if (str[i] == '#') {
            if (k > 0) {
                k--;
            }
        } else {
            processed[k++] = str[i];
        }
    }
    processed[k] = '\0';
    return processed;
}

bool backspaceCompare(char *s, char *t) {
    char* processedS = processString(s);
    char* processedT = processString(t);

    if (!processedS || !processedT) {
        if (processedS) free(processedS);
        if (processedT) free(processedT);
        return false; 
    }

    bool result = (strcmp(processedS, processedT) == 0);

    free(processedS);
    free(processedT);

    return result;
}