int* plusOne(int* digits, int digitsSize, int* returnSize) {
    int carry = 1;
    for (int i = digitsSize - 1; i >= 0; i--) {
        digits[i] += carry;
        if (digits[i] == 10) {
            digits[i] = 0;
            carry = 1;
        } else {
            carry = 0;
            break;
        }
    }
    if (carry) {
        int* result = (int*)malloc((digitsSize + 1) * sizeof(int));
        result[0] = 1;
        for (int i = 0; i < digitsSize; i++) {
            result[i + 1] = digits[i];
        }
        *returnSize = digitsSize + 1;
        return result;
    } else {
        *returnSize = digitsSize;
        return digits;
    }
}