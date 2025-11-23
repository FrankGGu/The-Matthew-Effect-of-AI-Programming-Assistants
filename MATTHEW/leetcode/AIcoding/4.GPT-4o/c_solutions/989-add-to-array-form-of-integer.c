typedef struct {
    int *digits;
    int size;
} ArrayForm;

int* addToArrayForm(int* A, int ASize, int K, int* returnSize) {
    int carry = K, i = ASize - 1;
    int *result = (int *)malloc((ASize > 0 ? ASize : 1) + 1 * sizeof(int));
    int index = 0;

    while (i >= 0 || carry > 0) {
        int sum = carry;
        if (i >= 0) {
            sum += A[i];
            i--;
        }
        result[index++] = sum % 10;
        carry = sum / 10;
    }

    *returnSize = index;
    for (int j = 0; j < index / 2; j++) {
        int temp = result[j];
        result[j] = result[index - 1 - j];
        result[index - 1 - j] = temp;
    }

    return result;
}