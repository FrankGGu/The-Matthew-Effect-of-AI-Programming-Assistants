int getLucky(char * s, int k) {
    int sum = 0;
    for (int i = 0; s[i] != '\0'; i++) {
        int val = s[i] - 'a' + 1;
        sum += (val / 10);
        sum += (val % 10);
    }

    for (int i = 1; i < k; i++) {
        int current_sum_of_digits = 0;
        while (sum > 0) {
            current_sum_of_digits += sum % 10;
            sum /= 10;
        }
        sum = current_sum_of_digits;
    }

    return sum;
}