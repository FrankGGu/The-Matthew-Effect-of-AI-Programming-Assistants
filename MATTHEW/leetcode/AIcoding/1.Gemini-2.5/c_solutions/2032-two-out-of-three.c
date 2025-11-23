#include <stdbool.h>
#include <stdlib.h>
#include <string.h>

int* twoOutOfThree(int* nums1, int nums1Size, int* nums2, int nums2Size, int* nums3, int nums3Size, int* returnSize) {
    bool seen1[101];
    bool seen2[101];
    bool seen3[101];

    memset(seen1, 0, sizeof(seen1));
    memset(seen2, 0, sizeof(seen2));
    memset(seen3, 0, sizeof(seen3));

    for (int i = 0; i < nums1Size; i++) {
        seen1[nums1[i]] = true;
    }

    for (int i = 0; i < nums2Size; i++) {
        seen2[nums2[i]] = true;
    }

    for (int i = 0; i < nums3Size; i++) {
        seen3[nums3[i]] = true;
    }

    int* result = (int*)malloc(100 * sizeof(int));
    if (result == NULL) {
        *returnSize = 0;
        return NULL;
    }

    int count = 0;
    for (int i = 1; i <= 100; i++) {
        if ((seen1[i] && seen2[i]) || (seen1[i] && seen3[i]) || (seen2[i] && seen3[i])) {
            result[count++] = i;
        }
    }

    *returnSize = count;
    return result;
}