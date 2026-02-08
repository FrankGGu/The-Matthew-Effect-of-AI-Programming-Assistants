int nextGreaterElement(int n) {
    long num = n, next = 0, factor = 1;
    int digits[10], count = 0;

    while (num > 0) {
        digits[count++] = num % 10;
        num /= 10;
    }

    for (int i = 0; i < count / 2; ++i) {
        int temp = digits[i];
        digits[i] = digits[count - 1 - i];
        digits[count - 1 - i] = temp;
    }

    int i = count - 2;
    while (i >= 0 && digits[i] >= digits[i + 1]) {
        i--;
    }

    if (i < 0) return -1;

    int j = count - 1;
    while (digits[j] <= digits[i]) {
        j--;
    }

    int temp = digits[i];
    digits[i] = digits[j];
    digits[j] = temp;

    for (int k = i + 1; k < (count + i + 1) / 2; k++) {
        temp = digits[k];
        digits[k] = digits[count - 1 - (k - i - 1)];
        digits[count - 1 - (k - i - 1)] = temp;
    }

    for (int k = count - 1; k >= 0; k--) {
        next += digits[k] * factor;
        factor *= 10;
    }

    return next > INT_MAX ? -1 : next;
}