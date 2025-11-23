int countDivisibleSubstrings(char * s) {
    int count = 0;
    int n = strlen(s);
    for (int i = 0; i < n; i++) {
        if (s[i] == '0') continue;
        int lastDigit = s[i] - '0';
        int num = 0;
        for (int j = i; j < n; j++) {
            num = num * 10 + (s[j] - '0');
            if (num % lastDigit == 0) {
                count++;
            }
        }
    }
    return count;
}