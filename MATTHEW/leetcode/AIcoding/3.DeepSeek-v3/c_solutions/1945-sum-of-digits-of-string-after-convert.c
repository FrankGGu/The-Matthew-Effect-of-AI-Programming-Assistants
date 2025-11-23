int getLucky(char* s, int k) {
    int sum = 0;

    // First conversion: letters to numbers
    for (int i = 0; s[i] != '\0'; i++) {
        int num = s[i] - 'a' + 1;
        while (num > 0) {
            sum += num % 10;
            num /= 10;
        }
    }

    // Subsequent transformations
    for (int i = 1; i < k; i++) {
        int new_sum = 0;
        while (sum > 0) {
            new_sum += sum % 10;
            sum /= 10;
        }
        sum = new_sum;
    }

    return sum;
}