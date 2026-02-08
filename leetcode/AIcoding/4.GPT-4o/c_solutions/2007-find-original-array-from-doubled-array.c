int* findOriginalArray(int* changed, int changedSize, int* returnSize) {
    if (changedSize % 2 != 0) {
        *returnSize = 0;
        return NULL;
    }

    int* original = (int*)malloc(sizeof(int) * (changedSize / 2));
    int* count = (int*)calloc(100001, sizeof(int));

    for (int i = 0; i < changedSize; i++) {
        count[changed[i]]++;
    }

    int index = 0;
    for (int i = 0; i <= 100000; i++) {
        while (count[i] > 0) {
            if (count[i * 2] == 0) {
                free(original);
                *returnSize = 0;
                return NULL;
            }
            original[index++] = i;
            count[i]--;
            count[i * 2]--;
        }
    }

    *returnSize = index;
    return original;
}