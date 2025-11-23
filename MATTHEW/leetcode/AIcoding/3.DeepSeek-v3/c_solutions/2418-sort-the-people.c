/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
char** sortPeople(char** names, int namesSize, int* heights, int heightsSize, int* returnSize) {
    *returnSize = namesSize;
    char** result = (char**)malloc(namesSize * sizeof(char*));
    int* indices = (int*)malloc(namesSize * sizeof(int));

    for (int i = 0; i < namesSize; i++) {
        indices[i] = i;
    }

    for (int i = 0; i < namesSize - 1; i++) {
        for (int j = 0; j < namesSize - i - 1; j++) {
            if (heights[indices[j]] < heights[indices[j + 1]]) {
                int temp = indices[j];
                indices[j] = indices[j + 1];
                indices[j + 1] = temp;
            }
        }
    }

    for (int i = 0; i < namesSize; i++) {
        result[i] = names[indices[i]];
    }

    free(indices);
    return result;
}