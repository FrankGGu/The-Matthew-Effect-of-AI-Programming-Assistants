#include <stdbool.h>

bool checkSubarraySum(int* nums, int numsSize, int k) {
    if (numsSize < 2) return false;

    int* modMap = (int*)malloc((k + 1) * sizeof(int));
    for (int i = 0; i <= k; i++) modMap[i] = -2;

    modMap[0] = -1;
    int sum = 0;

    for (int i = 0; i < numsSize; i++) {
        sum += nums[i];
        int mod = sum % k;
        if (mod < 0) mod += k;

        if (modMap[mod] != -2) {
            if (i - modMap[mod] > 1) {
                free(modMap);
                return true;
            }
        } else {
            modMap[mod] = i;
        }
    }

    free(modMap);
    return false;
}