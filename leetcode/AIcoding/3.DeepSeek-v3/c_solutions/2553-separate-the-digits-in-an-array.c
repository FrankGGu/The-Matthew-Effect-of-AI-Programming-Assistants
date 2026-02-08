/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* separateDigits(int* nums, int numsSize, int* returnSize) {
    int totalDigits = 0;
    for (int i = 0; i < numsSize; i++) {
        int n = nums[i];
        while (n > 0) {
            totalDigits++;
            n /= 10;
        }
    }

    int* result = (int*)malloc(totalDigits * sizeof(int));
    int index = totalDigits - 1;

    for (int i = numsSize - 1; i >= 0; i--) {
        int n = nums[i];
        while (n > 0) {
            result[index--] = n % 10;
            n /= 10;
        }
    }

    *returnSize = totalDigits;
    return result;
}