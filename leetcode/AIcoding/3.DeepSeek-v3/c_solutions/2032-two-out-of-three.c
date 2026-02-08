/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* twoOutOfThree(int* nums1, int nums1Size, int* nums2, int nums2Size, int* nums3, int nums3Size, int* returnSize) {
    int count[101][3] = {0};

    for (int i = 0; i < nums1Size; i++) {
        count[nums1[i]][0] = 1;
    }

    for (int i = 0; i < nums2Size; i++) {
        count[nums2[i]][1] = 1;
    }

    for (int i = 0; i < nums3Size; i++) {
        count[nums3[i]][2] = 1;
    }

    int* result = malloc(300 * sizeof(int));
    int idx = 0;

    for (int i = 1; i <= 100; i++) {
        int sum = count[i][0] + count[i][1] + count[i][2];
        if (sum >= 2) {
            result[idx++] = i;
        }
    }

    *returnSize = idx;
    return result;
}