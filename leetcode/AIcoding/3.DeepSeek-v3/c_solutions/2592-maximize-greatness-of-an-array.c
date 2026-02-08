int cmp(const void* a, const void* b) {
    return *(int*)a - *(int*)b;
}

int maximizeGreatness(int* nums, int numsSize) {
    qsort(nums, numsSize, sizeof(int), cmp);

    int i = 0, j = 0;
    while (j < numsSize) {
        if (nums[j] > nums[i]) {
            i++;
        }
        j++;
    }
    return i;
}