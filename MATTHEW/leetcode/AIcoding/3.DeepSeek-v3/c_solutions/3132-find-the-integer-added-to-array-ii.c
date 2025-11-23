#include <stdlib.h>

int cmp(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}

int minimumAddedInteger(int* nums1, int nums1Size, int* nums2, int nums2Size) {
    qsort(nums1, nums1Size, sizeof(int), cmp);
    qsort(nums2, nums2Size, sizeof(int), cmp);

    int min_x = INT_MAX;

    for (int i = 0; i < 3; i++) {
        for (int j = i + 1; j <= i + 2; j++) {
            int x = nums2[0] - nums1[i];
            int valid = 1;
            int idx1 = 0, idx2 = 0;
            int skip1 = i, skip2 = j;

            while (idx2 < nums2Size) {
                if (idx1 == skip1 || idx1 == skip2) {
                    idx1++;
                    continue;
                }
                if (nums2[idx2] - nums1[idx1] != x) {
                    valid = 0;
                    break;
                }
                idx1++;
                idx2++;
            }

            if (valid && x < min_x) {
                min_x = x;
            }
        }
    }

    return min_x;
}