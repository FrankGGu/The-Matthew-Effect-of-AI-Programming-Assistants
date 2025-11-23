#include <stdio.h>
#include <stdlib.h>

long long minArraySum(int* nums, int numsSize, int k, int maxSum) {
    int* freq = (int*)calloc(maxSum + 1, sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] <= maxSum) {
            freq[nums[i]]++;
        }
    }

    for (int i = 1; i <= maxSum; i++) {
        if (freq[i] == 0) continue;
        int count = freq[i];
        int next = i + 1;
        while (count > 0 && next <= maxSum) {
            int add = (next - i) * freq[i];
            if (add <= k) {
                k -= add;
                freq[next] += freq[i];
                freq[i] = 0;
                break;
            } else {
                int possible = k / (next - i);
                if (possible > 0) {
                    freq[next] += possible;
                    k -= possible * (next - i);
                    count -= possible;
                } else {
                    break;
                }
            }
            next++;
        }
    }

    long long sum = 0;
    for (int i = 1; i <= maxSum; i++) {
        sum += (long long)i * freq[i];
    }
    return sum;
}