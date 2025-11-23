int minimumPartition(char* s, int k) {
    int count = 0;
    long long current = 0;

    for (int i = 0; s[i] != '\0'; i++) {
        int digit = s[i] - '0';
        if (digit > k) return -1;

        current = current * 10 + digit;
        if (current > k) {
            count++;
            current = digit;
        }
    }

    return count + 1;
}