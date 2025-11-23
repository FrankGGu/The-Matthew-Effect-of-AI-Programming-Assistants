int maxPartitions(char *s) {
    int max_digit = 0, partitions = 0;
    for (int i = 0; s[i] != '\0'; i++) {
        int digit = s[i] - '0';
        if (digit > max_digit) {
            max_digit = digit;
            partitions++;
        }
    }
    return partitions;
}