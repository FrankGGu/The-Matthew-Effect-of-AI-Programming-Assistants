#include <stdio.h>
#include <stdlib.h>

int maxNumberOfGroups(int* parent, int parentSize) {
    int* count = (int*)calloc(parentSize, sizeof(int));
    for (int i = 0; i < parentSize; i++) {
        count[parent[i]]++;
    }
    int result = 0;
    for (int i = 0; i < parentSize; i++) {
        if (count[i] > 0) {
            result++;
        }
    }
    free(count);
    return result;
}