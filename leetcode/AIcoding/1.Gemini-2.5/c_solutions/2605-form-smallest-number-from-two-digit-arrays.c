#include <stdbool.h>

int min(int a, int b) {
    return a < b ? a : b;
}

int max(int a, int b) {
    return a > b ? a : b;
}

int formSmallestNumber(int* nums1, int nums1Size, int* nums2, int nums2Size) {
    int min1 = 10;
    int min2 = 10;
    bool seen[10] = {false};

    for (int i = 0; i < nums1Size; i++) {
        min1 = min(min1, nums1[i]);
        seen[nums1[i]] = true;
    }

    int min_common = 10;

    for (int i = 0; i < nums2Size; i++) {
        min2 = min(min2, nums2[i]);
        if (seen[nums2[i]]) {
            min_common = min(min_common, nums2[i]);
        }
    }

    if (min_common != 10) {
        return min(min_common, min(min1, min2) * 10 + max(min1, min2));
    } else {
        return min(min1, min2) * 10 + max(min1, min2);
    }
}