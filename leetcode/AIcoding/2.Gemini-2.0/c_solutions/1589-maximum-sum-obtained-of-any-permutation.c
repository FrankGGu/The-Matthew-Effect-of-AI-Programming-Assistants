#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int cmp(const void *a, const void *b) {
    return *(int*)b - *(int*)a;
}

int maximumSum(int* nums, int numsSize, int* requests, int requestsSize, int* requestsColSize){
    long long int *prefix = (long long int*)calloc(numsSize, sizeof(long long int));
    for(int i = 0; i < requestsSize; i++){
        prefix[requests[i * (*requestsColSize)]]++;
        if(requests[i * (*requestsColSize) + 1] + 1 < numsSize){
            prefix[requests[i * (*requestsColSize) + 1] + 1]--;
        }
    }
    for(int i = 1; i < numsSize; i++){
        prefix[i] += prefix[i - 1];
    }
    qsort(nums, numsSize, sizeof(int), cmp);
    qsort(prefix, numsSize, sizeof(long long int), cmp);
    long long int ans = 0;
    for(int i = 0; i < numsSize; i++){
        ans = (ans + ((long long int)nums[i] * prefix[i]) % 1000000007) % 1000000007;
    }
    free(prefix);
    return (int)ans;
}