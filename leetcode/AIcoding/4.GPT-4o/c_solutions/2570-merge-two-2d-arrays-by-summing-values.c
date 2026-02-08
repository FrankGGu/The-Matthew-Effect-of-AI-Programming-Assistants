int** mergeArrays(int** nums1, int nums1Size, int* nums1ColSize, int** nums2, int nums2Size, int* nums2ColSize, int* returnSize, int** returnColumnSizes) {
    int maxSize = nums1Size + nums2Size;
    int** merged = (int**)malloc(maxSize * sizeof(int*));
    *returnColumnSizes = (int*)malloc(maxSize * sizeof(int));
    int index = 0;

    for (int i = 0; i < nums1Size; i++) {
        int found = 0;
        for (int j = 0; j < index; j++) {
            if (merged[j][0] == nums1[i][0]) {
                merged[j][1] += nums1[i][1];
                found = 1;
                break;
            }
        }
        if (!found) {
            merged[index] = (int*)malloc(2 * sizeof(int));
            merged[index][0] = nums1[i][0];
            merged[index][1] = nums1[i][1];
            index++;
        }
    }

    for (int i = 0; i < nums2Size; i++) {
        int found = 0;
        for (int j = 0; j < index; j++) {
            if (merged[j][0] == nums2[i][0]) {
                merged[j][1] += nums2[i][1];
                found = 1;
                break;
            }
        }
        if (!found) {
            merged[index] = (int*)malloc(2 * sizeof(int));
            merged[index][0] = nums2[i][0];
            merged[index][1] = nums2[i][1];
            index++;
        }
    }

    *returnSize = index;
    for (int i = 0; i < index; i++) {
        (*returnColumnSizes)[i] = 2;
    }

    return merged;
}