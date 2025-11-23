/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* nextGreaterElement(int* nums1, int nums1Size, int* nums2, int nums2Size, int* returnSize) {
    *returnSize = nums1Size;
    int* result = (int*)malloc(nums1Size * sizeof(int));

    for (int i = 0; i < nums1Size; i++) {
        result[i] = -1;
        int found = 0;

        for (int j = 0; j < nums2Size; j++) {
            if (nums2[j] == nums1[i]) {
                found = 1;
            }

            if (found && nums2[j] > nums1[i]) {
                result[i] = nums2[j];
                break;
            }
        }
    }

    return result;
}