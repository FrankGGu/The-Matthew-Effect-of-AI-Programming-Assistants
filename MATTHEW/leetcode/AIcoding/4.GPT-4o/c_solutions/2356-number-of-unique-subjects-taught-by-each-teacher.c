int* uniqueSubjectsPerTeacher(int** subjects, int subjectsSize, int* subjectsColSize, int* returnSize) {
    int* result = (int*)malloc(subjectsSize * sizeof(int));
    for (int i = 0; i < subjectsSize; i++) {
        int* seen = (int*)calloc(101, sizeof(int));
        int count = 0;
        for (int j = 0; j < subjectsColSize[i]; j++) {
            if (!seen[subjects[i][j]]) {
                seen[subjects[i][j]] = 1;
                count++;
            }
        }
        result[i] = count;
        free(seen);
    }
    *returnSize = subjectsSize;
    return result;
}