/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* evenOddBit(int n, int* returnSize) {
    *returnSize = 2;
    int* result = (int*)malloc(2 * sizeof(int));
    result[0] = 0;
    result[1] = 0;

    int pos = 0;
    while (n > 0) {
        if (n & 1) {
            if (pos % 2 == 0) {
                result[0]++;
            } else {
                result[1]++;
            }
        }
        n >>= 1;
        pos++;
    }

    return result;
}