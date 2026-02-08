int maximumNumber(char* num, char* change) {
    int n = strlen(num);
    int mutated = 0;

    for (int i = 0; i < n; i++) {
        int digit = num[i] - '0';
        int new_digit = change[digit] - '0';

        if (new_digit > digit) {
            num[i] = change[digit];
            mutated = 1;
        } else if (new_digit < digit && mutated) {
            break;
        }
    }

    return atoi(num);
}