int maximumSwap(int num) {
    char digits[10];
    sprintf(digits, "%d", num);
    int n = strlen(digits);

    int max_idx[10];
    max_idx[n-1] = n-1;
    for (int i = n-2; i >= 0; i--) {
        max_idx[i] = (digits[i] > digits[max_idx[i+1]]) ? i : max_idx[i+1];
    }

    for (int i = 0; i < n; i++) {
        if (digits[i] < digits[max_idx[i]]) {
            char temp = digits[i];
            digits[i] = digits[max_idx[i]];
            digits[max_idx[i]] = temp;
            break;
        }
    }

    return atoi(digits);
}