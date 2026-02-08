int maximizeGreatness(int* nums, int numsSize) {
    qsort(nums, numsSize, sizeof(int), cmp);
    int greatness = 0;
    for (int i = 0, j = 0; i < numsSize; i++) {
        if (nums[i] > greatness) {
            greatness++;
        }
    }
    return greatness;
}

int cmp(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}