#include <stdlib.h>
#include <string.h>

int** reconstructQueue(int** people, int peopleSize, int* peopleColSize, int* returnSize, int** returnColumnSizes) {
    int** result = (int**)malloc(peopleSize * sizeof(int*));
    *returnColumnSizes = (int*)malloc(peopleSize * sizeof(int));
    for (int i = 0; i < peopleSize; i++) {
        result[i] = (int*)malloc(2 * sizeof(int));
        (*returnColumnSizes)[i] = 2;
    }
    *returnSize = peopleSize;

    int* indices = (int*)malloc(peopleSize * sizeof(int));
    for (int i = 0; i < peopleSize; i++) {
        indices[i] = i;
    }

    for (int i = 0; i < peopleSize - 1; i++) {
        for (int j = 0; j < peopleSize - i - 1; j++) {
            if (people[indices[j]][0] < people[indices[j + 1]][0] || 
                (people[indices[j]][0] == people[indices[j + 1]][0] && people[indices[j]][1] > people[indices[j + 1]][1])) {
                int temp = indices[j];
                indices[j] = indices[j + 1];
                indices[j + 1] = temp;
            }
        }
    }

    for (int i = 0; i < peopleSize; i++) {
        int pos = people[indices[i]][1];
        for (int j = i; j > pos; j--) {
            result[j][0] = result[j - 1][0];
            result[j][1] = result[j - 1][1];
        }
        result[pos][0] = people[indices[i]][0];
        result[pos][1] = people[indices[i]][1];
    }

    free(indices);
    return result;
}