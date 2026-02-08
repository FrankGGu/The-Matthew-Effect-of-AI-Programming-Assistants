/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

int* diffWaysToCompute(char* expression, int* returnSize) {
    int len = strlen(expression);
    int* result = NULL;
    *returnSize = 0;

    for (int i = 0; i < len; i++) {
        char c = expression[i];
        if (c == '+' || c == '-' || c == '*') {
            int leftSize = 0, rightSize = 0;
            char* leftExpr = (char*)malloc(i + 1);
            strncpy(leftExpr, expression, i);
            leftExpr[i] = '\0';

            char* rightExpr = (char*)malloc(len - i);
            strncpy(rightExpr, expression + i + 1, len - i - 1);
            rightExpr[len - i - 1] = '\0';

            int* leftResults = diffWaysToCompute(leftExpr, &leftSize);
            int* rightResults = diffWaysToCompute(rightExpr, &rightSize);

            free(leftExpr);
            free(rightExpr);

            for (int j = 0; j < leftSize; j++) {
                for (int k = 0; k < rightSize; k++) {
                    int val;
                    switch (c) {
                        case '+': val = leftResults[j] + rightResults[k]; break;
                        case '-': val = leftResults[j] - rightResults[k]; break;
                        case '*': val = leftResults[j] * rightResults[k]; break;
                    }

                    (*returnSize)++;
                    result = (int*)realloc(result, (*returnSize) * sizeof(int));
                    result[(*returnSize) - 1] = val;
                }
            }

            if (leftResults) free(leftResults);
            if (rightResults) free(rightResults);
        }
    }

    if (*returnSize == 0) {
        *returnSize = 1;
        result = (int*)malloc(sizeof(int));
        result[0] = atoi(expression);
    }

    return result;
}