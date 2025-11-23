int minimumSum(int num) {
    int digits[4];
    for (int i = 0; i < 4; i++) {
        digits[i] = num % 10;
        num /= 10;
    }
    qsort(digits, 4, sizeof(int), cmp);
    return (digits[0] * 10 + digits[2]) + (digits[1] * 10 + digits[3]);
}

int cmp(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}