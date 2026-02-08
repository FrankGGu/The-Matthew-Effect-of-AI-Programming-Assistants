#include <stdlib.h>
#include <string.h>

int* diffWaysToCompute(char *expression, int* returnSize) {
    int len = strlen(expression);
    int* result = malloc(1000 * sizeof(int));
    *returnSize = 0;

    for (int i = 0; i < len; i++) {
        if (expression[i] == '+' || expression[i] == '-' || expression[i] == '*') {
            char* left = strndup(expression, i);
            char* right = strdup(expression + i + 1);
            int leftSize, rightSize;
            int* leftResults = diffWaysToCompute(left, &leftSize);
            int* rightResults = diffWaysToCompute(right, &rightSize);
            for (int j = 0; j < leftSize; j++) {
                for (int k = 0; k < rightSize; k++) {
                    int res;
                    if (expression[i] == '+') {
                        res = leftResults[j] + rightResults[k];
                    } else if (expression[i] == '-') {
                        res = leftResults[j] - rightResults[k];
                    } else {
                        res = leftResults[j] * rightResults[k];
                    }
                    result[(*returnSize)++] = res;
                }
            }
            free(left);
            free(right);
            free(leftResults);
            free(rightResults);
        }
    }

    if (*returnSize == 0) {
        result[(*returnSize)++] = atoi(expression);
    }

    return result;
}