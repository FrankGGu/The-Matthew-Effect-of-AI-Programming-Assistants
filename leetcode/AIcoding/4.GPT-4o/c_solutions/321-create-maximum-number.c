int max(int a, int b) {
    return a > b ? a : b;
}

void merge(int* nums1, int nums1Size, int* nums2, int nums2Size, int* result) {
    int i = 0, j = 0, k = 0;
    while (i < nums1Size || j < nums2Size) {
        if (i < nums1Size && (j >= nums2Size || nums1[i] > nums2[j])) {
            result[k++] = nums1[i++];
        } else {
            result[k++] = nums2[j++];
        }
    }
}

void getMaxArray(int* nums, int numsSize, int k, int* result) {
    int stackSize = 0;
    for (int i = 0; i < numsSize; i++) {
        while (stackSize > 0 && stackSize + numsSize - i > k && result[stackSize - 1] < nums[i]) {
            stackSize--;
        }
        if (stackSize < k) {
            result[stackSize++] = nums[i];
        }
    }
}

int* maxNumber(int* nums1, int nums1Size, int* nums2, int nums2Size, int k, int* returnSize) {
    int* result = (int*)malloc(k * sizeof(int));
    *returnSize = k;
    for (int i = max(0, k - nums2Size); i <= min(k, nums1Size); i++) {
        int* temp1 = (int*)malloc(i * sizeof(int));
        int* temp2 = (int*)malloc((k - i) * sizeof(int));
        getMaxArray(nums1, nums1Size, i, temp1);
        getMaxArray(nums2, nums2Size, k - i, temp2);
        merge(temp1, i, temp2, k - i, result);
        free(temp1);
        free(temp2);
        if (i == 0 || memcmp(result, temp1, k * sizeof(int)) < 0) {
            memcpy(result, temp1, k * sizeof(int));
        }
    }
    return result;
}