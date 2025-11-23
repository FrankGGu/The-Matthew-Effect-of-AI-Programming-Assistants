/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
bool* prefixesDivBy5(int* nums, int numsSize, int* returnSize) {
    *returnSize = numsSize;
    bool* result = (bool*)malloc(numsSize * sizeof(bool));
    int remainder = 0;

    for (int i = 0; i < numsSize; i++) {
        remainder = (remainder * 2 + nums[i]) % 5;
        result[i] = (remainder == 0);
    }

    return result;
}