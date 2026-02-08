#include <stdio.h>
#include <stdlib.h>

int* createSortedArray(int* instructions, int instructionsSize, int* returnSize) {
    int* result = (int*)malloc(instructionsSize * sizeof(int));
    int* freq = (int*)calloc(100001, sizeof(int));
    int* temp = (int*)malloc(instructionsSize * sizeof(int));
    int index = 0;

    for (int i = 0; i < instructionsSize; i++) {
        int val = instructions[i];
        int count_less = 0;
        int count_greater = 0;

        for (int j = 0; j < val; j++) {
            count_less += freq[j];
        }

        for (int j = val + 1; j <= 100000; j++) {
            count_greater += freq[j];
        }

        result[i] = (count_less < count_greater) ? count_less : count_greater;
        freq[val]++;
    }

    *returnSize = instructionsSize;
    return result;
}