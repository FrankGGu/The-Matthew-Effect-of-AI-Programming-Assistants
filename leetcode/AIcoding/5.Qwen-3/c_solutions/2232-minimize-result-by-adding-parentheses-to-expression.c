#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* minimizeResult(char* expression) {
    int len = strlen(expression);
    int i, j;
    int plusPos = -1;
    for (i = 0; i < len; i++) {
        if (expression[i] == '+') {
            plusPos = i;
            break;
        }
    }

    int minVal = INT_MAX;
    char* result = (char*)malloc((len + 3) * sizeof(char));

    for (i = 0; i < plusPos; i++) {
        for (j = plusPos + 1; j < len; j++) {
            int left = atoi(expression + 0);
            int right = atoi(expression + j + 1);
            int mid = atoi(expression + i + 1);
            int total = left * mid + right;

            if (total < minVal) {
                minVal = total;
                snprintf(result, len + 3, "%s(%s)%s", expression + 0, expression + i + 1, expression + j + 1);
            }
        }
    }

    return result;
}