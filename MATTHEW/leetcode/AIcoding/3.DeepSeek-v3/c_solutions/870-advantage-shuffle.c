/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int cmp(const void* a, const void* b) {
    return *(int*)a - *(int*)b;
}

int* advantageCount(int* nums1, int nums1Size, int* nums2, int nums2Size, int* returnSize) {
    *returnSize = nums1Size;
    int* res = (int*)malloc(nums1Size * sizeof(int));
    int** nums2WithIndex = (int**)malloc(nums1Size * sizeof(int*));
    for (int i = 0; i < nums1Size; i++) {
        nums2WithIndex[i] = (int*)malloc(2 * sizeof(int));
        nums2WithIndex[i][0] = nums2[i];
        nums2WithIndex[i][1] = i;
    }

    qsort(nums1, nums1Size, sizeof(int), cmp);
    qsort(nums2WithIndex, nums1Size, sizeof(int*), cmp);

    int left = 0, right = nums1Size - 1;
    for (int i = nums1Size - 1; i >= 0; i--) {
        if (nums1[right] > nums2WithIndex[i][0]) {
            res[nums2WithIndex[i][1]] = nums1[right];
            right--;
        } else {
            res[nums2WithIndex[i][1]] = nums1[left];
            left++;
        }
    }

    for (int i = 0; i < nums1Size; i++) {
        free(nums2WithIndex[i]);
    }
    free(nums2WithIndex);

    return res;
}