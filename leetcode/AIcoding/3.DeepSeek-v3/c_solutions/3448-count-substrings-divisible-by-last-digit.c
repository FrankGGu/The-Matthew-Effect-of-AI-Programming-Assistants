int countSubstrings(char* s) {
    int n = strlen(s);
    int count = 0;

    for (int i = 0; i < n; i++) {
        int num = 0;
        for (int j = i; j < n; j++) {
            num = num * 10 + (s[j] - '0');
            int lastDigit = num % 10;
            if (lastDigit != 0 && num % lastDigit == 0) {
                count++;
            }
        }
    }

    return count;
}