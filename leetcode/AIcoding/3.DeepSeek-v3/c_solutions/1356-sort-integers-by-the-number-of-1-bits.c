/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int countBits(int num) {
    int count = 0;
    while (num) {
        count += num & 1;
        num >>= 1;
    }
    return count;
}

int compare(const void *a, const void *b) {
    int num1 = *(int*)a;
    int num2 = *(int*)b;

    int bits1 = countBits(num1);
    int bits2 = countBits(num2);

    if (bits1 == bits2) {
        return num1 - num2;
    }
    return bits1 - bits2;
}

int* sortByBits(int* arr, int arrSize, int* returnSize) {
    *returnSize = arrSize;
    qsort(arr, arrSize, sizeof(int), compare);
    return arr;
}