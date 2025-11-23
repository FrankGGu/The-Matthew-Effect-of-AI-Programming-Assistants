typedef struct {
    int sum;
    int i;
    int j;
} Pair;

int compare(const void* a, const void* b) {
    Pair* pa = (Pair*)a;
    Pair* pb = (Pair*)b;
    return pa->sum - pb->sum;
}

int** kSmallestPairs(int* nums1, int nums1Size, int* nums2, int nums2Size, int k, int* returnSize, int** returnColumnSizes) {
    if (nums1Size == 0 || nums2Size == 0 || k == 0) {
        *returnSize = 0;
        *returnColumnSizes = NULL;
        return NULL;
    }

    long long totalPairs = (long long)nums1Size * nums2Size;
    if (totalPairs > INT_MAX) totalPairs = INT_MAX;
    int pairsSize = totalPairs < k ? totalPairs : k;

    Pair* pairs = (Pair*)malloc(sizeof(Pair) * pairsSize);
    if (!pairs) {
        *returnSize = 0;
        *returnColumnSizes = NULL;
        return NULL;
    }

    int* indices = (int*)malloc(sizeof(int) * nums1Size);
    if (!indices) {
        free(pairs);
        *returnSize = 0;
        *returnColumnSizes = NULL;
        return NULL;
    }
    memset(indices, 0, sizeof(int) * nums1Size);

    int heapSize = 0;
    for (int i = 0; i < nums1Size && i < k; i++) {
        pairs[heapSize].sum = nums1[i] + nums2[0];
        pairs[heapSize].i = i;
        pairs[heapSize].j = 0;
        heapSize++;
    }

    int** result = (int**)malloc(sizeof(int*) * pairsSize);
    *returnColumnSizes = (int*)malloc(sizeof(int) * pairsSize);
    if (!result || !(*returnColumnSizes)) {
        free(pairs);
        free(indices);
        *returnSize = 0;
        return NULL;
    }

    for (int idx = 0; idx < pairsSize; idx++) {
        int minIdx = 0;
        for (int i = 1; i < heapSize; i++) {
            if (pairs[i].sum < pairs[minIdx].sum) {
                minIdx = i;
            }
        }

        Pair minPair = pairs[minIdx];
        result[idx] = (int*)malloc(sizeof(int) * 2);
        result[idx][0] = nums1[minPair.i];
        result[idx][1] = nums2[minPair.j];
        (*returnColumnSizes)[idx] = 2;

        if (minPair.j + 1 < nums2Size) {
            pairs[minIdx].sum = nums1[minPair.i] + nums2[minPair.j + 1];
            pairs[minIdx].j = minPair.j + 1;
        } else {
            if (minIdx != heapSize - 1) {
                pairs[minIdx] = pairs[heapSize - 1];
            }
            heapSize--;
        }

        if (heapSize == 0) {
            break;
        }
    }

    *returnSize = pairsSize;
    free(pairs);
    free(indices);
    return result;
}