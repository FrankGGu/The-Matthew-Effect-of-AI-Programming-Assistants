char *maximumNumber(char *num, int* change, int changeSize) {
    int n = strlen(num);
    int mutated = 0;

    for (int i = 0; i < n; i++) {
        int digit = num[i] - '0';
        if (digit < change[digit]) {
            mutated = 1;
            num[i] = change[digit] + '0';
        } else if (mutated && digit > change[digit]) {
            break;
        }
    }

    return num;
}