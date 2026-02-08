#include <stdlib.h>
#include <string.h>

int sumOfFlooredPairs(int* nums, int numsSize) {
    const int MOD = 1000000007;
    int maxNum = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > maxNum) maxNum = nums[i];
    }

    int* count = (int*)calloc(maxNum + 2, sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        count[nums[i]]++;
    }

    int* prefix = (int*)calloc(maxNum + 2, sizeof(int));
    for (int i = 1; i <= maxNum + 1; i++) {
        prefix[i] = prefix[i - 1] + count[i - 1];
    }

    long long result = 0;
    for (int i = 1; i <= maxNum; i++) {
        if (count[i] == 0) continue;

        for (int j = i; j <= maxNum; j += i) {
            int lower = j;
            int upper = j + i - 1;
            if (upper > maxNum) upper = maxNum;

            int freq = prefix[upper + 1] - prefix[lower];
            result = (result + (long long)count[i] * (j / i) * freq) % MOD;
        }
    }

    free(count);
    free(prefix);
    return result;
}