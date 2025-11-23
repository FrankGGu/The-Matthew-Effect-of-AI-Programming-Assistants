bool checkArray(int* nums, int numsSize, int k) {
    int* diff = (int*)calloc(numsSize + 1, sizeof(int));
    int curr = 0;

    for (int i = 0; i < numsSize; i++) {
        curr += diff[i];
        int val = nums[i] + curr;

        if (val < 0) {
            free(diff);
            return false;
        }

        if (val > 0) {
            if (i + k > numsSize) {
                free(diff);
                return false;
            }
            curr -= val;
            diff[i + k] += val;
        }
    }

    free(diff);
    return true;
}