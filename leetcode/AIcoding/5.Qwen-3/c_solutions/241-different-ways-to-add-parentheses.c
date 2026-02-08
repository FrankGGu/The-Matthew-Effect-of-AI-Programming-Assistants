#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int* data;
    int size;
} Result;

Result* createResult(int capacity) {
    Result* res = (Result*)malloc(sizeof(Result));
    res->data = (int*)malloc(capacity * sizeof(int));
    res->size = 0;
    return res;
}

void addResult(Result* res, int value) {
    res->data[res->size++] = value;
}

void freeResult(Result* res) {
    free(res->data);
    free(res);
}

int* diffWaysToCompute(char* expression, int* returnSize) {
    if (!expression || strlen(expression) == 0) {
        *returnSize = 0;
        return NULL;
    }

    Result* result = createResult(100);

    for (int i = 0; i < strlen(expression); i++) {
        if (expression[i] == '+' || expression[i] == '-' || expression[i] == '*') {
            int leftSize = 0;
            int* left = diffWaysToCompute(strndup(expression, i), &leftSize);
            int rightSize = 0;
            int* right = diffWaysToCompute(strdup(expression + i + 1), &rightSize);

            for (int l = 0; l < leftSize; l++) {
                for (int r = 0; r < rightSize; r++) {
                    int val;
                    if (expression[i] == '+') val = left[l] + right[r];
                    else if (expression[i] == '-') val = left[l] - right[r];
                    else val = left[l] * right[r];
                    addResult(result, val);
                }
            }

            free(left);
            free(right);
        }
    }

    if (result->size == 0) {
        int num = atoi(expression);
        addResult(result, num);
    }

    *returnSize = result->size;
    int* output = (int*)malloc(result->size * sizeof(int));
    memcpy(output, result->data, result->size * sizeof(int));
    freeResult(result);
    return output;
}