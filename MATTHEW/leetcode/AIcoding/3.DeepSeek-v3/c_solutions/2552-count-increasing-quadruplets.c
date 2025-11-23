int countQuadruplets(int* nums, int numsSize) {
    int n = numsSize;
    int res = 0;
    int* greater = (int*)malloc(n * n * sizeof(int));
    int* less = (int*)malloc(n * n * sizeof(int));

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            greater[i * n + j] = 0;
            less[i * n + j] = 0;
        }
    }

    for (int k = n - 2; k >= 0; k--) {
        for (int j = 0; j < n; j++) {
            greater[j * n + k] = greater[j * n + (k + 1)] + (nums[j] > nums[k + 1] ? 1 : 0);
        }
    }

    for (int j = 1; j < n; j++) {
        for (int i = 0; i < n; i++) {
            less[i * n + j] = less[i * n + (j - 1)] + (nums[i] < nums[j - 1] ? 1 : 0);
        }
    }

    for (int j = 0; j < n; j++) {
        for (int k = j + 1; k < n; k++) {
            if (nums[j] > nums[k]) {
                res += less[j * n + j] * greater[j * n + k];
            }
        }
    }

    free(greater);
    free(less);
    return res;
}