int minPartitions(char *n) {
    int maxDigit = 0;
    while (*n) {
        if (*n > maxDigit) {
            maxDigit = *n;
        }
        n++;
    }
    return maxDigit - '0';
}