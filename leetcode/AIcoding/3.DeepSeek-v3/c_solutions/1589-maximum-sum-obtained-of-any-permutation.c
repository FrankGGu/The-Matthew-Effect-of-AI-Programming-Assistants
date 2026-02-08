#include <stdlib.h>
#include <string.h>

int cmp(const void* a, const void* b) {
    return (*(long long*)a > *(long long*)b) ? 1 : -1;
}

int maxSumRangeQuery(int* nums, int numsSize, int** requests, int requestsSize, int* requestsColSize) {
    int* count = (int*)calloc(numsSize + 1, sizeof(int));

    for (int i = 0; i < requestsSize; i++) {
        int start = requests[i][0];
        int end = requests[i][1];
        count[start]++;
        if (end + 1 < numsSize) {
            count[end + 1]--;
        }
    }

    for (int i = 1; i < numsSize; i++) {
        count[i] += count[i - 1];
    }

    qsort(count, numsSize, sizeof(int), cmp);
    qsort(nums, numsSize, sizeof(int), cmp);

    long long result = 0;
    long long mod = 1000000007;

    for (int i = 0; i < numsSize; i++) {
        result = (result + (long long)count[i] * nums[i]) % mod;
    }

    free(count);
    return (int)result;
}