int* nextGreaterElement(int* nums1, int nums1Size, int* nums2, int nums2Size, int* returnSize) {
    int* result = (int*)malloc(nums1Size * sizeof(int));
    *returnSize = nums1Size;
    int* map = (int*)malloc(10001 * sizeof(int));
    for (int i = 0; i < 10001; i++) {
        map[i] = -1;
    }

    int* stack = (int*)malloc(nums2Size * sizeof(int));
    int top = -1;

    for (int i = 0; i < nums2Size; i++) {
        while (top != -1 && stack[top] < nums2[i]) {
            map[stack[top--]] = nums2[i];
        }
        stack[++top] = nums2[i];
    }

    for (int i = 0; i < nums1Size; i++) {
        result[i] = map[nums1[i]];
    }

    free(stack);
    free(map);
    return result;
}