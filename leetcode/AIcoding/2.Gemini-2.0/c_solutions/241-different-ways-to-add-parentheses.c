#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* diffWaysToCompute(char * expression, int* returnSize){
    int len = strlen(expression);
    int* result = (int*)malloc(1000 * sizeof(int));
    *returnSize = 0;

    if (strchr(expression, '+') == NULL && strchr(expression, '-') == NULL && strchr(expression, '*') == NULL) {
        result[(*returnSize)++] = atoi(expression);
        return result;
    }

    for (int i = 0; i < len; i++) {
        if (expression[i] == '+' || expression[i] == '-' || expression[i] == '*') {
            char left[len + 1];
            char right[len + 1];
            strncpy(left, expression, i);
            left[i] = '\0';
            strcpy(right, expression + i + 1);

            int leftSize = 0;
            int rightSize = 0;
            int* leftResult = diffWaysToCompute(left, &leftSize);
            int* rightResult = diffWaysToCompute(right, &rightSize);

            for (int j = 0; j < leftSize; j++) {
                for (int k = 0; k < rightSize; k++) {
                    int val;
                    if (expression[i] == '+') {
                        val = leftResult[j] + rightResult[k];
                    } else if (expression[i] == '-') {
                        val = leftResult[j] - rightResult[k];
                    } else {
                        val = leftResult[j] * rightResult[k];
                    }
                    result[(*returnSize)++] = val;
                }
            }

            free(leftResult);
            free(rightResult);
        }
    }

    return result;
}