int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

double minimumAverage(int* nums, int numsSize) {
    qsort(nums, numsSize, sizeof(int), compare);
    double minAvg = 1e9;
    for (int i = 0; i < numsSize / 2; i++) {
        double avg = (nums[i] + nums[numsSize - 1 - i]) / 2.0;
        if (avg < minAvg) {
            minAvg = avg;
        }
    }
    return minAvg;
}