int cmp(const void* a, const void* b) {
    return *(int*)b - *(int*)a;
}

bool backtrack(int* counts, int countsSize, int* quantity, int quantitySize, int idx) {
    if (idx == quantitySize) return true;

    for (int i = 0; i < countsSize; i++) {
        if (counts[i] >= quantity[idx]) {
            counts[i] -= quantity[idx];
            if (backtrack(counts, countsSize, quantity, quantitySize, idx + 1)) {
                return true;
            }
            counts[i] += quantity[idx];
        }
    }
    return false;
}

bool canDistribute(int* nums, int numsSize, int* quantity, int quantitySize) {
    int freq[1001] = {0};
    for (int i = 0; i < numsSize; i++) {
        freq[nums[i]]++;
    }

    int counts[50] = {0};
    int countsSize = 0;
    for (int i = 0; i < 1001; i++) {
        if (freq[i] > 0) {
            counts[countsSize++] = freq[i];
        }
    }

    qsort(quantity, quantitySize, sizeof(int), cmp);
    qsort(counts, countsSize, sizeof(int), cmp);

    return backtrack(counts, countsSize, quantity, quantitySize, 0);
}