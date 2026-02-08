#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char * minRemoveToMakeValid(char * s){
    int len = strlen(s);
    char *result = (char *)malloc(sizeof(char) * (len + 1));
    int balance = 0;
    int j = 0;

    for (int i = 0; i < len; i++) {
        if (s[i] == '(') {
            balance++;
            result[j++] = s[i];
        } else if (s[i] == ')') {
            if (balance > 0) {
                balance--;
                result[j++] = s[i];
            }
        } else {
            result[j++] = s[i];
        }
    }

    result[j] = '\0';

    int openCount = 0;
    for (int i = 0; i < j; i++) {
        if (result[i] == '(') {
            openCount++;
        }
    }

    char *finalResult = (char *)malloc(sizeof(char) * (len + 1));
    int k = 0;
    for (int i = 0; i < j; i++) {
        if (result[i] == '(' && openCount > balance) {
            openCount--;
        } else {
            finalResult[k++] = result[i];
        }
    }

    finalResult[k] = '\0';

    free(result);
    return finalResult;
}