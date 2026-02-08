void wiggleSort(int* nums, int numsSize) {
    int* tmp = (int*)malloc(numsSize * sizeof(int));
    memcpy(tmp, nums, numsSize * sizeof(int));
    qsort(tmp, numsSize, sizeof(int), cmp);

    int mid = (numsSize - 1) / 2;
    int j = mid + 1;
    for (int i = 0; i < numsSize; i++) {
        nums[i] = (i % 2 == 0) ? tmp[mid - i / 2] : tmp[j++];
    }
    free(tmp);
}

int cmp(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}