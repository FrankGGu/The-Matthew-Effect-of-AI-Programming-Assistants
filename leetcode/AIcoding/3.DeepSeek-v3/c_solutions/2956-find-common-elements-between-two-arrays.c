/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* findIntersectionValues(int* nums1, int nums1Size, int* nums2, int nums2Size, int* returnSize) {
    int* result = (int*)malloc(2 * sizeof(int));
    *returnSize = 2;
    result[0] = 0;
    result[1] = 0;

    int count1[101] = {0};
    int count2[101] = {0};

    for (int i = 0; i < nums1Size; i++) {
        count1[nums1[i]]++;
    }

    for (int i = 0; i < nums2Size; i++) {
        count2[nums2[i]]++;
    }

    for (int i = 0; i < nums1Size; i++) {
        if (count2[nums1[i]] > 0) {
            result[0]++;
        }
    }

    for (int i = 0; i < nums2Size; i++) {
        if (count1[nums2[i]] > 0) {
            result[1]++;
        }
    }

    return result;
}