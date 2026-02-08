int* getSubarrayBeauty(int* nums, int numsSize, int k, int x, int* returnSize) {
    int* result = (int*)malloc(sizeof(int) * (numsSize - k + 1));
    *returnSize = numsSize - k + 1;

    int count[101] = {0}; // -50 to 50 mapped to 0-100

    for (int i = 0; i < k; i++) {
        count[nums[i] + 50]++;
    }

    for (int i = 0; i <= numsSize - k; i++) {
        int pos = 0;
        int beauty = 0;

        for (int j = 0; j <= 100; j++) {
            pos += count[j];
            if (pos >= x) {
                if (j < 50) {
                    beauty = j - 50;
                }
                break;
            }
        }

        result[i] = beauty;

        if (i < numsSize - k) {
            count[nums[i] + 50]--;
            count[nums[i + k] + 50]++;
        }
    }

    return result;
}