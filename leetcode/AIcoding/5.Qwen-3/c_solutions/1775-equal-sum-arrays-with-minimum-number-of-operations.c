#include <stdio.h>
#include <stdlib.h>

int getSum(int* nums, int numsSize) {
    int sum = 0;
    for (int i = 0; i < numsSize; i++) {
        sum += nums[i];
    }
    return sum;
}

int compare(const void* a, const void* b) {
    return (*(int*)b - *(int*)a);
}

int minOperations(int* nums1, int nums1Size, int* nums2, int nums2Size) {
    int sum1 = getSum(nums1, nums1Size);
    int sum2 = getSum(nums2, nums2Size);

    if (sum1 == sum2) return 0;

    if (sum1 < sum2) {
        int* temp = nums1;
        nums1 = nums2;
        nums2 = temp;

        int t = nums1Size;
        nums1Size = nums2Size;
        nums2Size = t;

        t = sum1;
        sum1 = sum2;
        sum2 = t;
    }

    qsort(nums1, nums1Size, sizeof(int), compare);
    qsort(nums2, nums2Size, sizeof(int), compare);

    int i = 0, j = 0, ops = 0;
    while (i < nums1Size || j < nums2Size) {
        if (i < nums1Size && j < nums2Size) {
            int diff1 = nums1[i] - 1;
            int diff2 = 6 - nums2[j];
            if (diff1 >= diff2) {
                sum1 -= diff1;
                i++;
            } else {
                sum2 += diff2;
                j++;
            }
        } else if (i < nums1Size) {
            sum1 -= (nums1[i] - 1);
            i++;
        } else {
            sum2 += (6 - nums2[j]);
            j++;
        }
        ops++;
        if (sum1 == sum2) break;
    }

    return ops;
}