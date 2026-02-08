/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* maxNumber(int* nums1, int nums1Size, int* nums2, int nums2Size, int k, int* returnSize) {
    int* res = (int*)malloc(sizeof(int) * k);
    *returnSize = k;

    for (int i = 0; i <= k; i++) {
        if (i > nums1Size || k - i > nums2Size) continue;

        int* sub1 = maxSubsequence(nums1, nums1Size, i);
        int* sub2 = maxSubsequence(nums2, nums2Size, k - i);
        int* merged = merge(sub1, i, sub2, k - i);

        if (compare(merged, res, k, 0) > 0) {
            memcpy(res, merged, sizeof(int) * k);
        }

        free(sub1);
        free(sub2);
        free(merged);
    }

    return res;
}

int* maxSubsequence(int* nums, int size, int k) {
    if (k == 0) return NULL;
    int* stack = (int*)malloc(sizeof(int) * k);
    int top = -1;
    int remain = size - k;

    for (int i = 0; i < size; i++) {
        while (top >= 0 && stack[top] < nums[i] && remain > 0) {
            top--;
            remain--;
        }
        if (top < k - 1) {
            stack[++top] = nums[i];
        } else {
            remain--;
        }
    }

    return stack;
}

int* merge(int* nums1, int size1, int* nums2, int size2) {
    int* res = (int*)malloc(sizeof(int) * (size1 + size2));
    int i = 0, j = 0, idx = 0;

    while (i < size1 && j < size2) {
        if (compare(nums1, nums2, size1 - i, size2 - j) > 0) {
            res[idx++] = nums1[i++];
        } else {
            res[idx++] = nums2[j++];
        }
    }

    while (i < size1) res[idx++] = nums1[i++];
    while (j < size2) res[idx++] = nums2[j++];

    return res;
}

int compare(int* nums1, int* nums2, int size1, int size2) {
    int minSize = size1 < size2 ? size1 : size2;
    for (int i = 0; i < minSize; i++) {
        if (nums1[i] != nums2[i]) {
            return nums1[i] - nums2[i];
        }
    }
    return size1 - size2;
}