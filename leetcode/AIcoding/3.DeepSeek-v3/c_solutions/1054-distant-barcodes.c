/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
typedef struct {
    int value;
    int count;
} Pair;

int cmp(const void* a, const void* b) {
    return ((Pair*)b)->count - ((Pair*)a)->count;
}

int* rearrangeBarcodes(int* barcodes, int barcodesSize, int* returnSize) {
    int count[10001] = {0};
    int maxCount = 0, maxNum = 0;

    for (int i = 0; i < barcodesSize; i++) {
        count[barcodes[i]]++;
        if (count[barcodes[i]] > maxCount) {
            maxCount = count[barcodes[i]];
            maxNum = barcodes[i];
        }
    }

    Pair* pairs = malloc(10001 * sizeof(Pair));
    int pairSize = 0;
    for (int i = 1; i <= 10000; i++) {
        if (count[i] > 0) {
            pairs[pairSize].value = i;
            pairs[pairSize].count = count[i];
            pairSize++;
        }
    }

    qsort(pairs, pairSize, sizeof(Pair), cmp);

    int* result = malloc(barcodesSize * sizeof(int));
    *returnSize = barcodesSize;
    int idx = 0;

    for (int i = 0; i < pairs[0].count; i++) {
        result[idx] = pairs[0].value;
        idx += 2;
        if (idx >= barcodesSize) idx = 1;
    }

    for (int i = 1; i < pairSize; i++) {
        for (int j = 0; j < pairs[i].count; j++) {
            result[idx] = pairs[i].value;
            idx += 2;
            if (idx >= barcodesSize) idx = 1;
        }
    }

    free(pairs);
    return result;
}