int* nextGreaterElement(int* nums1, int nums1Size, int* nums2, int nums2Size, int* returnSize) {
    int* result = (int*)malloc(sizeof(int) * nums1Size);
    *returnSize = nums1Size;

    int stack[nums2Size];
    int top = -1;
    int map[10001]; 

    for (int i = 0; i < nums2Size; i++) {
        while (top != -1 && nums2[i] > stack[top]) {
            map[stack[top]] = nums2[i];
            top--;
        }
        stack[++top] = nums2[i];
    }

    while (top != -1) {
        map[stack[top]] = -1;
        top--;
    }

    for (int i = 0; i < nums1Size; i++) {
        result[i] = map[nums1[i]];
    }

    return result;
}