#include <stdlib.h>

int minOperations(int* nums1, int nums1Size, int* nums2, int nums2Size) {
    if (nums1Size > nums2Size * 6 || nums2Size > nums1Size * 6) return -1;

    int sum1 = 0, sum2 = 0;
    for (int i = 0; i < nums1Size; i++) sum1 += nums1[i];
    for (int i = 0; i < nums2Size; i++) sum2 += nums2[i];

    if (sum1 == sum2) return 0;

    int diff = abs(sum1 - sum2);
    int count[7] = {0};

    for (int i = 0; i < nums1Size; i++) count[nums1[i]]++;
    for (int i = 0; i < nums2Size; i++) count[6 - nums2[i]]++;

    int operations = 0;
    for (int i = 6; i > 0 && diff > 0; i--) {
        while (count[i] > 0 && diff > 0) {
            diff -= i;
            count[i]--;
            operations++;
        }
    }

    return diff > 0 ? -1 : operations;
}