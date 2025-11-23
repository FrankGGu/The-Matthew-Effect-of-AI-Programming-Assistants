/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* addToArrayForm(int* num, int numSize, int k, int* returnSize) {
    int* result = malloc((numSize + 10) * sizeof(int));
    int carry = 0;
    int idx = numSize - 1;
    int resultIdx = 0;

    while (k > 0 || idx >= 0 || carry > 0) {
        int digit = carry;
        if (idx >= 0) {
            digit += num[idx];
            idx--;
        }
        if (k > 0) {
            digit += k % 10;
            k /= 10;
        }

        carry = digit / 10;
        result[resultIdx++] = digit % 10;
    }

    *returnSize = resultIdx;

    for (int i = 0; i < resultIdx / 2; i++) {
        int temp = result[i];
        result[i] = result[resultIdx - i - 1];
        result[resultIdx - i - 1] = temp;
    }

    return result;
}