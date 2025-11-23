/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* sortEvenOdd(int* nums, int numsSize, int* returnSize) {
    *returnSize = numsSize;
    int* result = (int*)malloc(numsSize * sizeof(int));

    // Separate even and odd indices
    int evenCount = (numsSize + 1) / 2;
    int oddCount = numsSize / 2;

    int* evenArr = (int*)malloc(evenCount * sizeof(int));
    int* oddArr = (int*)malloc(oddCount * sizeof(int));

    for (int i = 0; i < numsSize; i++) {
        if (i % 2 == 0) {
            evenArr[i / 2] = nums[i];
        } else {
            oddArr[i / 2] = nums[i];
        }
    }

    // Sort even indices in non-decreasing order
    for (int i = 0; i < evenCount - 1; i++) {
        for (int j = 0; j < evenCount - i - 1; j++) {
            if (evenArr[j] > evenArr[j + 1]) {
                int temp = evenArr[j];
                evenArr[j] = evenArr[j + 1];
                evenArr[j + 1] = temp;
            }
        }
    }

    // Sort odd indices in non-increasing order
    for (int i = 0; i < oddCount - 1; i++) {
        for (int j = 0; j < oddCount - i - 1; j++) {
            if (oddArr[j] < oddArr[j + 1]) {
                int temp = oddArr[j];
                oddArr[j] = oddArr[j + 1];
                oddArr[j + 1] = temp;
            }
        }
    }

    // Merge back
    for (int i = 0; i < numsSize; i++) {
        if (i % 2 == 0) {
            result[i] = evenArr[i / 2];
        } else {
            result[i] = oddArr[i / 2];
        }
    }

    free(evenArr);
    free(oddArr);

    return result;
}