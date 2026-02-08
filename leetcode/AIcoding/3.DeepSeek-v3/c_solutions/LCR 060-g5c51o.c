/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
typedef struct {
    int num;
    int freq;
} NumFreq;

int compare(const void* a, const void* b) {
    return ((NumFreq*)b)->freq - ((NumFreq*)a)->freq;
}

int* topKFrequent(int* nums, int numsSize, int k, int* returnSize) {
    *returnSize = k;

    if (numsSize == 0) {
        return NULL;
    }

    int min = nums[0], max = nums[0];
    for (int i = 1; i < numsSize; i++) {
        if (nums[i] < min) min = nums[i];
        if (nums[i] > max) max = nums[i];
    }

    int range = max - min + 1;
    int* freq = (int*)calloc(range, sizeof(int));

    for (int i = 0; i < numsSize; i++) {
        freq[nums[i] - min]++;
    }

    NumFreq* numFreqs = (NumFreq*)malloc(range * sizeof(NumFreq));
    int count = 0;

    for (int i = 0; i < range; i++) {
        if (freq[i] > 0) {
            numFreqs[count].num = i + min;
            numFreqs[count].freq = freq[i];
            count++;
        }
    }

    qsort(numFreqs, count, sizeof(NumFreq), compare);

    int* result = (int*)malloc(k * sizeof(int));
    for (int i = 0; i < k; i++) {
        result[i] = numFreqs[i].num;
    }

    free(freq);
    free(numFreqs);

    return result;
}