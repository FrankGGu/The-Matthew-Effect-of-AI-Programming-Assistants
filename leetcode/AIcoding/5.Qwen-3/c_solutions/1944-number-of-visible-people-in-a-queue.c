#include <stdio.h>
#include <stdlib.h>

int* visiblePeople(int* people, int peopleSize, int* returnSize) {
    int* result = (int*)malloc(peopleSize * sizeof(int));
    int* stack = (int*)malloc(peopleSize * sizeof(int));
    int top = -1;

    for (int i = 0; i < peopleSize; i++) {
        while (top >= 0 && people[stack[top]] <= people[i]) {
            result[stack[top]]++;
            top--;
        }
        if (top >= 0) {
            result[i]++;
        }
        stack[++top] = i;
    }

    *returnSize = peopleSize;
    free(stack);
    return result;
}