/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* findOriginalArray(int* changed, int changedSize, int* returnSize) {
    if (changedSize % 2 != 0) {
        *returnSize = 0;
        return NULL;
    }

    int max_val = 0;
    for (int i = 0; i < changedSize; i++) {
        if (changed[i] > max_val) {
            max_val = changed[i];
        }
    }

    int* count = (int*)calloc(max_val + 1, sizeof(int));
    for (int i = 0; i < changedSize; i++) {
        count[changed[i]]++;
    }

    int* original = (int*)malloc((changedSize / 2) * sizeof(int));
    int idx = 0;

    if (count[0] % 2 != 0) {
        *returnSize = 0;
        free(count);
        free(original);
        return NULL;
    }

    for (int i = 0; i <= max_val; i++) {
        while (count[i] > 0) {
            if (i * 2 > max_val || count[i * 2] == 0) {
                *returnSize = 0;
                free(count);
                free(original);
                return NULL;
            }
            original[idx++] = i;
            count[i]--;
            count[i * 2]--;
        }
    }

    *returnSize = changedSize / 2;
    free(count);
    return original;
}