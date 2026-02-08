int chalkReplacer(int* chalk, int chalkSize, int k) {
    long totalChalk = 0;
    for (int i = 0; i < chalkSize; i++) {
        totalChalk += chalk[i];
    }
    k %= totalChalk;
    for (int i = 0; i < chalkSize; i++) {
        if (k < chalk[i]) {
            return i;
        }
        k -= chalk[i];
    }
    return -1;
}