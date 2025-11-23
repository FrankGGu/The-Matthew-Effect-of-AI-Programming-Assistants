int getSubarrayBeauty(int* nums, int numsSize, int k, int x) {
    int* freq = (int*)calloc(101, sizeof(int));
    int* result = (int*)malloc((numsSize - k + 1) * sizeof(int));
    int left = 0, right = 0, count = 0;

    for (right = 0; right < k; right++) {
        freq[nums[right] + 50]++;
    }

    for (int i = 0; i <= numsSize - k; i++) {
        if (i > 0) {
            freq[nums[i - 1] + 50]--;
            freq[nums[i + k - 1] + 50]++;
        }

        count = 0;
        for (int j = 0; j < 50; j++) {
            count += freq[j];
        }

        if (count >= x) {
            result[i] = -1;
        } else {
            for (int j = 0; j < 101; j++) {
                if (freq[j] > 0) {
                    result[i] = j - 50;
                    break;
                }
            }
        }
    }

    int* finalResult = (int*)malloc((numsSize - k + 1) * sizeof(int));
    for (int i = 0; i <= numsSize - k; i++) {
        finalResult[i] = result[i];
    }

    free(freq);
    free(result);
    return finalResult;
}