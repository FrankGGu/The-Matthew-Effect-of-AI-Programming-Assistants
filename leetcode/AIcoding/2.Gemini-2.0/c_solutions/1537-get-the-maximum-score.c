#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MOD 1000000007

int max(int a, int b) {
    return (a > b) ? a : b;
}

int maxSum(int* nums1, int nums1Size, int* nums2, int nums2Size) {
    long long sum1 = 0, sum2 = 0;
    int i = 0, j = 0;
    long long result = 0;

    while (i < nums1Size || j < nums2Size) {
        if (i < nums1Size && (j == nums2Size || nums1[i] < nums2[j])) {
            sum1 += nums1[i];
            i++;
        } else if (j < nums2Size && (i == nums1Size || nums2[j] < nums1[i])) {
            sum2 += nums2[j];
            j++;
        } else {
            result = (result + max(sum1, sum2) + nums1[i]) % MOD;
            sum1 = 0;
            sum2 = 0;
            i++;
            j++;
        }
    }

    result = (result + max(sum1, sum2)) % MOD;
    return (int)result;
}