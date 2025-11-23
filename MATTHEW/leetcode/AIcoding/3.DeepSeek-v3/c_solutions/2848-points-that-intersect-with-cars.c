int numberOfPoints(int** nums, int numsSize, int* numsColSize) {
    int max_end = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i][1] > max_end) {
            max_end = nums[i][1];
        }
    }

    int* covered = (int*)calloc(max_end + 2, sizeof(int));

    for (int i = 0; i < numsSize; i++) {
        covered[nums[i][0]] += 1;
        covered[nums[i][1] + 1] -= 1;
    }

    int count = 0;
    int current = 0;
    for (int i = 1; i <= max_end; i++) {
        current += covered[i];
        if (current > 0) {
            count++;
        }
    }

    free(covered);
    return count;
}