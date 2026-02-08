char * constructDistancedSequence(int n, int* returnSize) {
    int size = 2 * n - 1;
    char *result = (char *)malloc(size + 1);
    int *pos = (int *)calloc(size, sizeof(int));
    for (int i = 0; i < size; i++) {
        result[i] = '0';
    }
    result[size] = '\0';

    for (int i = n; i > 0; i--) {
        for (int j = 0; j < size; j++) {
            if (result[j] == '0' && (j + i < size && result[j + i] == '0')) {
                result[j] = i + '0';
                result[j + i] = i + '0';
                break;
            }
        }
    }

    *returnSize = size;
    free(pos);
    return result;
}