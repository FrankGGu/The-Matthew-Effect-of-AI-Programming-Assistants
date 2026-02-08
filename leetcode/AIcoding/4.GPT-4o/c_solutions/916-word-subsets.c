#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int* wordSubsets(char** A, int ASize, char** B, int BSize, int* returnSize) {
    int count[26] = {0};
    int* result = (int*)malloc(ASize * sizeof(int));
    *returnSize = 0;

    for (int i = 0; i < BSize; i++) {
        int temp[26] = {0};
        for (int j = 0; j < strlen(B[i]); j++) {
            temp[B[i][j] - 'a']++;
        }
        for (int k = 0; k < 26; k++) {
            if (temp[k] > count[k]) {
                count[k] = temp[k];
            }
        }
    }

    for (int i = 0; i < ASize; i++) {
        int temp[26] = {0};
        for (int j = 0; j < strlen(A[i]); j++) {
            temp[A[i][j] - 'a']++;
        }
        int valid = 1;
        for (int k = 0; k < 26; k++) {
            if (temp[k] < count[k]) {
                valid = 0;
                break;
            }
        }
        if (valid) {
            result[(*returnSize)++] = i;
        }
    }

    return result;
}