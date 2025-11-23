#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minOperations(int* nums1, int nums1Size, int* nums2, int nums2Size) {
    int op1 = 0, op2 = 0;
    int last1 = nums1[nums1Size - 1], last2 = nums2[nums2Size - 1];

    for (int i = 0; i < nums1Size - 1; i++) {
        if (nums1[i] > last1 && nums2[i] > last1) return -1;
        if (nums1[i] > last1) op1++;
        else if (nums2[i] > last1) continue;
        else if (nums1[i] > last2 && nums2[i] <= last1) op1++;
    }

    for (int i = 0; i < nums1Size - 1; i++) {
        if (nums1[i] > last2 && nums2[i] > last2) return -1;
        if (nums1[i] > last2) op2++;
        else if (nums2[i] > last2) continue;
        else if (nums1[i] > last1 && nums2[i] <= last2) op2++;
    }

    if (op1 == -1 && op2 == -1) return -1;
    if (op1 == -1) return op2;
    if (op2 == -1) return op1;

    return (op1 < op2) ? op1 : op2;
}