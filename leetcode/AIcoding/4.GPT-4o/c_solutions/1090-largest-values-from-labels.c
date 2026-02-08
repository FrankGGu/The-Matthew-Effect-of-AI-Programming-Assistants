#define MAX_N 2000

int largestValues(int* values, int valuesSize, int* labels, int labelsSize, int numWanted, int useLimit, int* returnSize) {
    int count[100001] = {0};
    int result = 0;

    int** pairs = malloc(valuesSize * sizeof(int*));
    for (int i = 0; i < valuesSize; i++) {
        pairs[i] = malloc(2 * sizeof(int));
        pairs[i][0] = values[i];
        pairs[i][1] = labels[i];
    }

    qsort(pairs, valuesSize, sizeof(int*), [](const void* a, const void* b) {
        return (*(int**)b)[0] - (*(int**)a)[0];
    });

    *returnSize = 0;
    for (int i = 0; i < valuesSize && *returnSize < numWanted; i++) {
        int label = pairs[i][1];
        if (count[label] < useLimit) {
            result += pairs[i][0];
            count[label]++;
            (*returnSize)++;
        }
    }

    for (int i = 0; i < valuesSize; i++) {
        free(pairs[i]);
    }
    free(pairs);

    return result;
}